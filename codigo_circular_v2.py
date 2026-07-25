import argparse
import math
import zlib
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle


# ============================================================
# CONFIGURAÇÕES
# ============================================================

# --- Geometria dos anéis (raio reduzido / mais compacto, estilo App Clip) ---
CIRCULO_INICIAL = 95          # <- era 130. Puxa os anéis para mais perto do centro.
LARGURA_PREENCHIDA = 8        # <- traço mais fino, para o gap ter espaço de sobra
ESPACO_VAZIO = 7
QUANTIDADE_FAIXAS_PREENCHIDAS = 5

# IMPORTANTE: este número não pode ser escolhido livremente. Cada slot
# (traço + gap) precisa de espaço de arco real para existir; com traços
# grossos e raios pequenos, 1222 slots deixavam menos de meia unidade por
# traço — bem menor que a espessura do próprio traço, então as pontas
# arredondadas se encostavam e comiam o gap inteiro (por isso ele "sumia").
# 140 é o valor calibrado para esta espessura/raio deixarem o gap visível.
TOTAL_PARTICOES = 100 # 400

PASTA_SAIDA = Path("codigos_circulares")
NOME_ARQUIVO_PADRAO = "codigo_circular_balanceado.png"

COR_FUNDO = "#231F20"
COR_BIT_1 = "#FFFFFF"
COR_BIT_0 = "#8A8A8A"

ROTACOES_FAIXAS = [0.0, 7.0, 15.0, 24.0, 34.0]

# --- Gaps padronizados (fixos em graus, iguais em todos os anéis) ---
# Antes o gap era proporcional ao ângulo de cada partição, então variava de
# anel para anel. Agora é um valor absoluto e fixo: isso garante visualmente
# que duas cores nunca se tocam, e o tamanho do "respiro" é sempre o mesmo
# não importa o raio do anel.
#
# O pulo do gato: em vez de usar um único valor de gap (puramente estético),
# usamos DOIS valores padronizados. Qual deles aparece em cada fronteira
# entre traços passa a ser, ele mesmo, um bit de dado. Ou seja, cada traço
# carrega 2 bits: a COR dele (1 bit) e a LARGURA do gap logo depois dele
# (1 bit). Isso dobra a capacidade útil sem mexer no número de partições.
_ESPESSURA_TRACO = LARGURA_PREENCHIDA / (2 * math.pi)
GAP_ESTREITO_UNIDADES = _ESPESSURA_TRACO * 1.35   # bit 0 no canal de gap
GAP_LARGO_UNIDADES = _ESPESSURA_TRACO * 2.7       # bit 1 no canal de gap

MOSTRAR_ROTULOS_FAIXA = False
MOSTRAR_CIRCULOS_REFERENCIA = False
MOSTRAR_IMAGEM_AO_FINAL = True

MAGIC = b"CQ"
VERSAO = 2
TAMANHO_CABECALHO = 9
SEMENTE_MASCARA = 0x6D2B79F5


# ============================================================
# ENTRADA PELO TERMINAL
# ============================================================

def ler_argumentos():
    parser = argparse.ArgumentParser(
        description=(
            "Gera um código circular de cinco anéis, usando cor + largura "
            "do gap entre traços como dois canais de dado independentes."
        )
    )
    parser.add_argument("conteudo", nargs="?", help="Link ou texto que será codificado.")
    parser.add_argument("-o", "--saida", default=NOME_ARQUIVO_PADRAO,
                         help=f"Nome do PNG de saída. Padrão: {NOME_ARQUIVO_PADRAO}")
    parser.add_argument("--nao-mostrar", action="store_true",
                         help="Salva a imagem sem abrir a janela do Matplotlib.")
    return parser.parse_args()


def solicitar_conteudo(conteudo_argumento=None):
    if conteudo_argumento:
        conteudo = conteudo_argumento.strip()
    else:
        print()
        conteudo = input("Digite ou cole o link/texto que deseja codificar:\n> ").strip()
    if not conteudo:
        raise ValueError("O link ou texto não pode ficar vazio.")
    return conteudo


# ============================================================
# GEOMETRIA
# ============================================================

def construir_tabela(inicio, largura, espaco, n_faixas):
    circulos = []
    faixas_preenchidas = []
    atual = inicio
    for _ in range(n_faixas):
        c_inicial = atual
        c_final = atual + largura
        faixas_preenchidas.append((c_inicial, c_final))
        circulos.extend([c_inicial, c_final])
        atual = c_final + espaco
    return circulos, faixas_preenchidas


def distribuir_particoes(faixas, total_particoes):
    medias = [(inicio + fim) / 2 for inicio, fim in faixas]
    soma_medias = sum(medias)
    valores_reais = [total_particoes * media / soma_medias for media in medias]
    partes_base = [int(valor) for valor in valores_reais]
    resto = total_particoes - sum(partes_base)
    fracoes = [valor - int(valor) for valor in valores_reais]
    indices_ordenados = sorted(range(len(fracoes)), key=lambda i: fracoes[i], reverse=True)
    for indice in range(resto):
        partes_base[indices_ordenados[indice]] += 1
    return partes_base


def circunferencia_para_raio(circunferencia):
    return circunferencia / (2 * math.pi)


# ============================================================
# CONVERSÃO ENTRE BYTES E BITS
# ============================================================

def bytes_para_bits(dados):
    bits = []
    for byte in dados:
        for posicao in range(7, -1, -1):
            bits.append((byte >> posicao) & 1)
    return bits


def bits_para_bytes(bits):
    quantidade_utilizavel = (len(bits) // 8) * 8
    bits = bits[:quantidade_utilizavel]
    resultado = bytearray()
    for inicio in range(0, len(bits), 8):
        valor = 0
        for bit in bits[inicio:inicio + 8]:
            valor = (valor << 1) | bit
        resultado.append(valor)
    return bytes(resultado)


# ============================================================
# MÁSCARA REVERSÍVEL / WHITENING
# ============================================================

def gerar_bit_mascara(quantidade, semente=SEMENTE_MASCARA):
    estado = semente & 0xFFFFFFFF
    mascara = []
    for _ in range(quantidade):
        estado ^= (estado << 13) & 0xFFFFFFFF
        estado ^= (estado >> 17) & 0xFFFFFFFF
        estado ^= (estado << 5) & 0xFFFFFFFF
        estado &= 0xFFFFFFFF
        mascara.append(estado & 1)
    return mascara


def aplicar_mascara(bits, semente=SEMENTE_MASCARA):
    mascara = gerar_bit_mascara(len(bits), semente)
    return [bit ^ mascara_bit for bit, mascara_bit in zip(bits, mascara)]


# ============================================================
# PACOTE DE DADOS
# ============================================================

def criar_pacote(conteudo):
    payload = conteudo.encode("utf-8")
    checksum = zlib.crc32(payload) & 0xFFFFFFFF
    cabecalho = bytearray()
    cabecalho.extend(MAGIC)
    cabecalho.append(VERSAO)
    cabecalho.extend(len(payload).to_bytes(2, byteorder="big"))
    cabecalho.extend(checksum.to_bytes(4, byteorder="big"))
    return bytes(cabecalho) + payload


def decodificar_pacote(dados):
    if len(dados) < TAMANHO_CABECALHO:
        raise ValueError("O pacote recuperado está incompleto.")
    if dados[:2] != MAGIC:
        raise ValueError("A assinatura do código é inválida.")
    versao = dados[2]
    if versao != VERSAO:
        raise ValueError(f"Versão não suportada: {versao}.")
    tamanho_payload = int.from_bytes(dados[3:5], byteorder="big")
    checksum_esperado = int.from_bytes(dados[5:9], byteorder="big")
    inicio_payload = TAMANHO_CABECALHO
    fim_payload = inicio_payload + tamanho_payload
    payload = dados[inicio_payload:fim_payload]
    if len(payload) != tamanho_payload:
        raise ValueError("O conteúdo recuperado está incompleto.")
    checksum_real = zlib.crc32(payload) & 0xFFFFFFFF
    if checksum_real != checksum_esperado:
        raise ValueError("O CRC32 não corresponde ao conteúdo recuperado.")
    return payload.decode("utf-8")


def calcular_capacidade():
    # Cada partição/traço agora carrega 2 bits reais: 1 pela cor, 1 pela
    # largura do gap que vem depois dele. Por isso a capacidade total em
    # bits é 2 * TOTAL_PARTICOES, e não apenas TOTAL_PARTICOES como antes.
    capacidade_total_bits = TOTAL_PARTICOES * 2
    capacidade_total_bytes = capacidade_total_bits // 8
    capacidade_payload = capacidade_total_bytes - TAMANHO_CABECALHO
    return capacidade_total_bytes, capacidade_payload


def preparar_bits_codificados(conteudo):
    pacote = criar_pacote(conteudo)
    bits_pacote = bytes_para_bits(pacote)
    capacidade_total_bits = TOTAL_PARTICOES * 2
    if len(bits_pacote) > capacidade_total_bits:
        _, capacidade_payload = calcular_capacidade()
        tamanho_payload = len(conteudo.encode("utf-8"))
        raise ValueError(
            "\nO conteúdo é grande demais para esta configuração.\n"
            f"Payload atual: {tamanho_payload} bytes.\n"
            f"Capacidade máxima aproximada: {capacidade_payload} bytes.\n"
        )
    bits_logicos = bits_pacote + [0] * (capacidade_total_bits - len(bits_pacote))
    bits_visuais = aplicar_mascara(bits_logicos)

    # Divide o fluxo mascarado em dois canais do mesmo tamanho:
    # a primeira metade vira COR, a segunda metade vira GAP.
    bits_cor = bits_visuais[:TOTAL_PARTICOES]
    bits_gap = bits_visuais[TOTAL_PARTICOES:]
    return bits_cor, bits_gap, pacote


def recuperar_bits_logicos(bits_cor, bits_gap):
    bits_visuais = list(bits_cor) + list(bits_gap)
    return aplicar_mascara(bits_visuais)


def distribuir_canal_nas_faixas(bits, particoes_por_faixa):
    resultado = []
    cursor = 0
    for quantidade in particoes_por_faixa:
        fim = cursor + quantidade
        resultado.append(bits[cursor:fim])
        cursor = fim
    if cursor != len(bits):
        raise ValueError("A quantidade de bits não corresponde à quantidade total de partições.")
    return resultado


# ============================================================
# DESENHO (traços com pontas arredondadas, gap padronizado e informativo)
# ============================================================

def desenhar_codigo_circular(faixas, particoes, circulos, cor_por_faixa, gap_por_faixa,
                              arquivo_saida, mostrar_imagem=True):
    fig, ax = plt.subplots(figsize=(10, 10))
    ax.set_aspect("equal")
    ax.set_facecolor(COR_FUNDO)
    fig.patch.set_facecolor(COR_FUNDO)
    ax.axis("off")

    raio_maximo = circunferencia_para_raio(max(circulos))
    margem = raio_maximo * 0.10
    ax.set_xlim(-(raio_maximo + margem), raio_maximo + margem)
    ax.set_ylim(-(raio_maximo + margem), raio_maximo + margem)

    fig.canvas.draw()
    p0 = ax.transData.transform((0, 0))
    p1 = ax.transData.transform((1, 0))
    pontos_por_unidade = math.hypot(p1[0] - p0[0], p1[1] - p0[1]) * 72.0 / fig.dpi

    for indice, (faixa, quantidade_particoes, bits_cor_faixa, bits_gap_faixa) in enumerate(
        zip(faixas, particoes, cor_por_faixa, gap_por_faixa)
    ):
        circunferencia_interna, circunferencia_externa = faixa
        raio_interno = circunferencia_para_raio(circunferencia_interna)
        raio_externo = circunferencia_para_raio(circunferencia_externa)
        raio_meio = (raio_interno + raio_externo) / 2
        espessura = raio_externo - raio_interno
        linewidth_pontos = espessura * pontos_por_unidade

        n = quantidade_particoes
        angulo_slot = 360 / n
        rotacao = ROTACOES_FAIXAS[indice % len(ROTACOES_FAIXAS)]

        # Converte os gaps (fixos em unidades de ARCO) para graus, usando o
        # raio deste anel. Isso garante o mesmo tamanho FÍSICO de respiro em
        # todos os anéis, mesmo com raios e quantidades de traços diferentes.
        gap_estreito_graus = math.degrees(GAP_ESTREITO_UNIDADES / raio_meio)
        gap_largo_graus = math.degrees(GAP_LARGO_UNIDADES / raio_meio)

        def grau_inicio_slot(k, rotacao=rotacao, angulo_slot=angulo_slot):
            return rotacao + k * angulo_slot

        for k in range(n):
            # Gap ANTES deste traço = gap "depois" do traço anterior (anel fechado).
            gap_antes_bit = bits_gap_faixa[(k - 1) % n]
            gap_depois_bit = bits_gap_faixa[k]
            gap_antes_graus = gap_largo_graus if gap_antes_bit else gap_estreito_graus
            gap_depois_graus = gap_largo_graus if gap_depois_bit else gap_estreito_graus

            angulo_inicial = grau_inicio_slot(k) + gap_antes_graus / 2
            angulo_final = grau_inicio_slot(k + 1) - gap_depois_graus / 2

            if angulo_final <= angulo_inicial:
                # Segurança para anéis com poucas partições / gaps grandes.
                centro = (grau_inicio_slot(k) + grau_inicio_slot(k + 1)) / 2
                angulo_inicial = centro - angulo_slot * 0.15
                angulo_final = centro + angulo_slot * 0.15

            cor = COR_BIT_1 if bits_cor_faixa[k] else COR_BIT_0

            angulos_rad = np.linspace(
                math.radians(angulo_inicial), math.radians(angulo_final), 10
            )
            xs = raio_meio * np.cos(angulos_rad)
            ys = raio_meio * np.sin(angulos_rad)

            ax.plot(
                xs, ys,
                color=cor,
                linewidth=linewidth_pontos,
                solid_capstyle="round",
                solid_joinstyle="round",
                antialiased=True,
            )

        if MOSTRAR_ROTULOS_FAIXA:
            ax.text(
                0, raio_meio, f"Faixa {indice + 1}\n{quantidade_particoes} partes",
                ha="center", va="center", fontsize=8, color="white",
                bbox={"facecolor": COR_FUNDO, "edgecolor": "white", "alpha": 0.80}
            )

    if MOSTRAR_CIRCULOS_REFERENCIA:
        for circunferencia in circulos:
            raio = circunferencia_para_raio(circunferencia)
            ax.add_patch(Circle((0, 0), raio, fill=False, edgecolor="white",
                                 linewidth=0.7, linestyle="--", alpha=0.35))

    plt.tight_layout()
    arquivo_saida.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(arquivo_saida, dpi=300, bbox_inches="tight", facecolor=COR_FUNDO)

    if mostrar_imagem:
        plt.show()
    else:
        plt.close(fig)


# ============================================================
# VALIDAÇÃO
# ============================================================

def validar_codificacao(bits_cor, bits_gap):
    bits_logicos = recuperar_bits_logicos(bits_cor, bits_gap)
    dados = bits_para_bytes(bits_logicos)
    return decodificar_pacote(dados)


# ============================================================
# EXECUÇÃO
# ============================================================

def main():
    argumentos = ler_argumentos()
    try:
        conteudo = solicitar_conteudo(argumentos.conteudo)
        nome_saida = argumentos.saida.strip()
        if not nome_saida.lower().endswith(".png"):
            nome_saida += ".png"
        arquivo_saida = PASTA_SAIDA / nome_saida

        circulos, faixas = construir_tabela(
            inicio=CIRCULO_INICIAL, largura=LARGURA_PREENCHIDA,
            espaco=ESPACO_VAZIO, n_faixas=QUANTIDADE_FAIXAS_PREENCHIDAS
        )
        particoes = distribuir_particoes(faixas=faixas, total_particoes=TOTAL_PARTICOES)
        bits_cor, bits_gap, pacote = preparar_bits_codificados(conteudo)
        cor_por_faixa = distribuir_canal_nas_faixas(bits=bits_cor, particoes_por_faixa=particoes)
        gap_por_faixa = distribuir_canal_nas_faixas(bits=bits_gap, particoes_por_faixa=particoes)
        conteudo_validado = validar_codificacao(bits_cor, bits_gap)
        capacidade_total, capacidade_payload = calcular_capacidade()

        print("\n" + "=" * 66)
        print("CÓDIGO CIRCULAR BALANCEADO — CINCO ANÉIS (COR + GAP = 2 BITS/TRAÇO)")
        print("=" * 66)
        print(f"\nConteúdo informado:\n{conteudo}")
        print("\nDistribuição das 1222 partições:")
        for indice, (faixa, quantidade) in enumerate(zip(faixas, particoes), start=1):
            inicio, fim = faixa
            bits_c = cor_por_faixa[indice - 1]
            bits_g = gap_por_faixa[indice - 1]
            print(f"Faixa {indice}: {inicio} → {fim} | {quantidade} traços | "
                  f"cor 1: {sum(bits_c)} / cor 0: {len(bits_c) - sum(bits_c)} | "
                  f"gap largo: {sum(bits_g)} / gap estreito: {len(bits_g) - sum(bits_g)}")
        print(f"\nTotal de traços: {sum(particoes)}")
        print(f"Bits reais do pacote: {len(bytes_para_bits(pacote))}")
        print(f"Capacidade total: {capacidade_total} bytes completos (2 bits por traço)")
        print(f"Capacidade do conteúdo: {capacidade_payload} bytes")
        print(f"Validação interna: {conteudo_validado}")

        desenhar_codigo_circular(
            faixas=faixas, particoes=particoes, circulos=circulos,
            cor_por_faixa=cor_por_faixa, gap_por_faixa=gap_por_faixa,
            arquivo_saida=arquivo_saida,
            mostrar_imagem=(MOSTRAR_IMAGEM_AO_FINAL and not argumentos.nao_mostrar)
        )
        print(f"\nImagem salva em:\n{arquivo_saida.resolve()}")

    except KeyboardInterrupt:
        print("\nOperação cancelada pelo usuário.")
    except ValueError as erro:
        print(f"\nErro: {erro}")
    except Exception as erro:
        print(f"\nOcorreu um erro inesperado: {type(erro).__name__}: {erro}")


if __name__ == "__main__":
    main()
