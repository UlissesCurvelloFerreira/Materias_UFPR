import argparse
import math
from itertools import groupby

import numpy as np
from PIL import Image

# Reaproveita a geometria e o "protocolo" de bits definidos no gerador.
# O decodificador PRECISA conhecer as mesmas constantes usadas para gerar
# o código (raios, número de traços, tamanhos de gap etc.) — é o mesmo
# princípio de qualquer código de barras/QR: quem lê precisa da mesma
# especificação de quem gerou.
from codigo_circular_v2 import (
    CIRCULO_INICIAL, LARGURA_PREENCHIDA, ESPACO_VAZIO,
    QUANTIDADE_FAIXAS_PREENCHIDAS, TOTAL_PARTICOES, ROTACOES_FAIXAS,
    GAP_ESTREITO_UNIDADES, GAP_LARGO_UNIDADES,
    COR_FUNDO, COR_BIT_1, COR_BIT_0,
    construir_tabela, distribuir_particoes, circunferencia_para_raio,
    recuperar_bits_logicos, bits_para_bytes, decodificar_pacote,
)


def hex_para_rgb(cor_hex):
    cor_hex = cor_hex.lstrip("#")
    return tuple(int(cor_hex[i:i + 2], 16) for i in (0, 2, 4))


COR_FUNDO_RGB = np.array(hex_para_rgb(COR_FUNDO), dtype=float)
COR_BIT_1_RGB = np.array(hex_para_rgb(COR_BIT_1), dtype=float)
COR_BIT_0_RGB = np.array(hex_para_rgb(COR_BIT_0), dtype=float)


# ============================================================
# CALIBRAÇÃO: encontrar centro e escala (pixels por unidade de dado)
# ============================================================

def calibrar_centro_e_escala(cinza, raios_esperados):
    """Usa um perfil radial de brilho médio para achar a escala px/unidade.

    Convertemos o objetivo geométrico (raios das 5 faixas, em unidades de
    dado) em picos de brilho na imagem, e resolvemos a escala que melhor
    alinha os raios esperados aos picos detectados.
    """
    altura, largura = cinza.shape
    centro_x, centro_y = largura / 2.0, altura / 2.0
    raio_max_px = min(largura, altura) / 2.0 - 2

    amostras_raio = np.linspace(5, raio_max_px, 600)
    angulos = np.linspace(0, 2 * math.pi, 360, endpoint=False)
    cos_a, sin_a = np.cos(angulos), np.sin(angulos)

    perfil = np.zeros_like(amostras_raio)
    for i, r in enumerate(amostras_raio):
        xs = (centro_x + r * cos_a).astype(int)
        ys = (centro_y - r * sin_a).astype(int)
        validos = (xs >= 0) & (xs < largura) & (ys >= 0) & (ys < altura)
        perfil[i] = cinza[ys[validos], xs[validos]].mean() if validos.any() else 0

    # Picos = raios em pixels onde, em média, existe traço (fundo é escuro,
    # traço é claro), então olhamos onde o brilho médio sobe bastante.
    limiar = (perfil.max() + perfil.min()) / 2
    acima = perfil > limiar
    grupos_px = []
    for valor, grupo in groupby(range(len(acima)), key=lambda i: acima[i]):
        indices = list(grupo)
        if valor:
            centro_grupo = amostras_raio[indices[len(indices) // 2]]
            grupos_px.append(centro_grupo)

    if len(grupos_px) < len(raios_esperados):
        raise ValueError(
            f"Não foi possível localizar os {len(raios_esperados)} anéis na "
            f"imagem (achei {len(grupos_px)} picos de brilho). A imagem pode "
            f"estar cortada, girada ou não corresponder a este formato."
        )

    # Usa os últimos N picos encontrados (do centro para fora), que devem
    # corresponder às N faixas, na mesma ordem.
    picos_px = sorted(grupos_px)[-len(raios_esperados):]
    escala = np.mean(np.array(picos_px) / np.array(raios_esperados))
    return centro_x, centro_y, escala


# ============================================================
# LEITURA DE UM ANEL
# ============================================================

def calcular_limiar_adaptativo(valores):
    """Acha o melhor ponto de corte entre dois aglomerados (gap estreito x
    largo) olhando o maior "salto" entre valores consecutivos ordenados.

    Não usamos os valores de projeto (GAP_ESTREITO_UNIDADES/GAP_LARGO_UNIDADES)
    porque a ponta arredondada do traço "come" parte do gap na renderização,
    deslocando os valores reais medidos na imagem para baixo dos valores de
    projeto. O limiar precisa vir dos dados observados, não do desenho ideal.
    """
    valores_ordenados = np.sort(np.asarray(valores))
    diffs = np.diff(valores_ordenados)
    indice_maior_salto = int(np.argmax(diffs))
    return (valores_ordenados[indice_maior_salto] + valores_ordenados[indice_maior_salto + 1]) / 2


def ler_faixa_bruta(cinza, centro_x, centro_y, escala, raio_meio_dado,
                     n_slots, rotacao_graus, resolucao_angular=0.05):
    """Lê um anel e devolve os bits de cor + o vão (em unidades de dado)
    medido após cada traço, SEM classificar o vão em estreito/largo ainda
    (isso é feito depois, com o limiar adaptativo global)."""
    raio_px = raio_meio_dado * escala
    n_amostras = int(360 / resolucao_angular)
    angulos_graus = np.linspace(0, 360, n_amostras, endpoint=False)
    angulos_rad = np.radians(angulos_graus)

    xs = (centro_x + raio_px * np.cos(angulos_rad)).astype(int)
    ys = (centro_y - raio_px * np.sin(angulos_rad)).astype(int)
    altura, largura = cinza.shape
    xs = np.clip(xs, 0, largura - 1)
    ys = np.clip(ys, 0, altura - 1)
    brilho = cinza[ys, xs]

    limiar_fundo = (COR_FUNDO_RGB.mean() + COR_BIT_0_RGB.mean()) / 2
    primeiro_plano = brilho > limiar_fundo

    # Agrupa em segmentos contíguos (circular: o fim do array conecta com o começo).
    n = len(primeiro_plano)
    grupos = []
    indice = 0
    primeiro_plano_rot = primeiro_plano.copy()
    # Gira o array para começar numa borda de transição, evitando que um
    # traço fique "quebrado" entre o fim e o começo do array.
    transicoes = np.where(primeiro_plano_rot != np.roll(primeiro_plano_rot, 1))[0]
    deslocamento = transicoes[0] if len(transicoes) else 0
    primeiro_plano_rot = np.roll(primeiro_plano_rot, -deslocamento)
    angulos_rot = np.roll(angulos_graus, -deslocamento)
    brilho_rot = np.roll(brilho, -deslocamento)

    for valor, grupo_iter in groupby(range(n), key=lambda i: primeiro_plano_rot[i]):
        indices = list(grupo_iter)
        angulo_centro = angulos_rot[indices[len(indices) // 2]]
        angulo_ini = angulos_rot[indices[0]]
        angulo_fim = angulos_rot[indices[-1]]
        comprimento_graus = (len(indices) / n) * 360
        cor_media = brilho_rot[indices].mean() if valor else None
        grupos.append({
            "traco": bool(valor),
            "angulo_centro": angulo_centro,
            "comprimento_graus": comprimento_graus,
            "cor_media": cor_media,
        })

    tracos = [g for g in grupos if g["traco"]]
    gaps = [g for g in grupos if not g["traco"]]

    if len(tracos) != n_slots:
        raise ValueError(
            f"Esperava {n_slots} traços neste anel, mas detectei {len(tracos)}. "
            "Ajuste a resolução angular ou verifique se a imagem é nítida o "
            "suficiente."
        )

    # Reordena os traços para casar com o índice k=0..n-1 do gerador,
    # usando o ângulo esperado do slot 0 como referência.
    def angulo_esperado(k):
        return (rotacao_graus + (k + 0.5) * (360 / n_slots)) % 360

    ang0_esperado = angulo_esperado(0)
    tracos_ordenados = sorted(tracos, key=lambda t: t["angulo_centro"])
    # gira a lista para o traço mais próximo do slot 0 ficar em primeiro
    diffs = [min(abs(t["angulo_centro"] - ang0_esperado),
                 360 - abs(t["angulo_centro"] - ang0_esperado)) for t in tracos_ordenados]
    indice_zero = int(np.argmin(diffs))
    tracos_ordenados = tracos_ordenados[indice_zero:] + tracos_ordenados[:indice_zero]

    ponto_meio_cores = (COR_BIT_1_RGB.mean() + COR_BIT_0_RGB.mean()) / 2
    bits_cor = [1 if t["cor_media"] > ponto_meio_cores else 0 for t in tracos_ordenados]

    # O gap "depois" do slot k é o espaço vazio entre o traço k e o traço k+1.
    # Aqui só MEDIMOS o vão em unidades de dado; a classificação em
    # estreito/largo acontece depois, com o limiar adaptativo global.
    vaos_dado = []
    for k in range(n_slots):
        atual = tracos_ordenados[k]["angulo_centro"]
        prox = tracos_ordenados[(k + 1) % n_slots]["angulo_centro"]
        vao_graus = (prox - atual) % 360
        # subtrai o "corpo" médio dos dois traços para isolar só o gap.
        vao_graus -= (tracos_ordenados[k]["comprimento_graus"] +
                      tracos_ordenados[(k + 1) % n_slots]["comprimento_graus"]) / 2
        vao_graus = max(vao_graus, 0.001)
        vaos_dado.append(math.radians(vao_graus) * raio_meio_dado)

    return bits_cor, vaos_dado


# ============================================================
# DECODIFICAÇÃO COMPLETA
# ============================================================

def decodificar_imagem(caminho_imagem):
    imagem = Image.open(caminho_imagem).convert("RGB")
    arr = np.array(imagem, dtype=float)
    cinza = arr.mean(axis=2)

    circulos, faixas = construir_tabela(
        inicio=CIRCULO_INICIAL, largura=LARGURA_PREENCHIDA,
        espaco=ESPACO_VAZIO, n_faixas=QUANTIDADE_FAIXAS_PREENCHIDAS
    )
    particoes = distribuir_particoes(faixas=faixas, total_particoes=TOTAL_PARTICOES)
    raios_meio_dado = [
        (circunferencia_para_raio(c0) + circunferencia_para_raio(c1)) / 2
        for c0, c1 in faixas
    ]

    centro_x, centro_y, escala = calibrar_centro_e_escala(cinza, raios_meio_dado)

    # 1ª passada: lê cor (já classificada) e vãos BRUTOS de todos os anéis.
    cor_por_faixa, vaos_por_faixa = [], []
    for i, (raio_meio, n_slots) in enumerate(zip(raios_meio_dado, particoes)):
        rotacao = ROTACOES_FAIXAS[i % len(ROTACOES_FAIXAS)]
        bits_cor, vaos_dado = ler_faixa_bruta(
            cinza, centro_x, centro_y, escala, raio_meio, n_slots, rotacao
        )
        cor_por_faixa.append(bits_cor)
        vaos_por_faixa.append(vaos_dado)

    # Limiar de gap calculado a partir dos dados observados na própria
    # imagem (todos os anéis juntos), não do valor "ideal" de projeto.
    todos_os_vaos = [v for faixa in vaos_por_faixa for v in faixa]
    limiar_gap = calcular_limiar_adaptativo(todos_os_vaos)

    # 2ª passada: classifica os vãos em bit 0 (estreito) / bit 1 (largo).
    bits_cor_total, bits_gap_total = [], []
    for bits_cor, vaos_dado in zip(cor_por_faixa, vaos_por_faixa):
        bits_cor_total.extend(bits_cor)
        bits_gap_total.extend(1 if v > limiar_gap else 0 for v in vaos_dado)

    bits_logicos = recuperar_bits_logicos(bits_cor_total, bits_gap_total)
    dados = bits_para_bytes(bits_logicos)
    return decodificar_pacote(dados)


def main():
    parser = argparse.ArgumentParser(
        description="Decodifica um código circular (PNG) gerado por codigo_circular_v2.py"
    )
    parser.add_argument("imagem", help="Caminho do arquivo PNG a decodificar.")
    argumentos = parser.parse_args()

    try:
        conteudo = decodificar_imagem(argumentos.imagem)
        print("\nConteúdo decodificado com sucesso:\n")
        print(conteudo)
    except Exception as erro:
        print(f"\nErro ao decodificar: {type(erro).__name__}: {erro}")


if __name__ == "__main__":
    main()
