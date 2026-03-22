{
  Faça um programa em Free Pascal que:
  1. Leia um número natural n (0 < n ≤ 100).
  2. Leia uma sequência de n números naturais.
  3. Verifique se existem duas subsequências iguais na sequência com tamanho pelo menos 2.
     - Caso existam, o tamanho da subsequência encontrada deve ser máximo.
     - O programa deve imprimir:
       i m
       onde i é a posição da primeira ocorrência da subsequência repetida e m é o tamanho da subsequência.
  4. Caso não exista subsequência repetida, imprimir "nenhuma".

  Observações:
  - Os casos de teste não conterão entradas com mais de uma subsequência igual.
  - A sugestão de estrutura inclui:
    - Um procedimento ler_vetor para ler o vetor de entrada.
    - Uma função tem_subsequencia_iguais que retorna a posição da primeira subsequência igual de determinado tamanho ou zero se não existir.
  - O programa principal utiliza um laço decrescente do tamanho máximo possível de subsequência (n div 2) até 2 para encontrar a subsequência de maior tamanho.

  Exemplo de entrada 1:
  8
  7 9 5 4 5 5 4 6

  Saída esperada 1:
  3 2

  Exemplo de entrada 2:
  12
  2 7 9 5 2 5 4 8 6 2 5 4

  Saída esperada 2:
  5 3
}


program escolha_um_nome_bom;

const
    MAX = 100;

type
    vetor = array [1..MAX] of longint;

var
    v : vetor;
    n, pos, tamanho_subsequencia: longint;

procedure ler_vetor (var v: vetor; n: longint);
var
    i: longint;
begin
    for i := 1 to n do
        read(v[i]);
end;

function subsequencias_iguais(var v: vetor; start1, start2, tam: longint): boolean;
var
    i: longint;
begin
    for i := 0 to tam-1 do
    begin
        if v[start1 + i] <> v[start2 + i] then
        begin
            subsequencias_iguais := false;
            exit;
        end;
    end;
    subsequencias_iguais := true;
end;

function tem_subsequencia_iguais(var v: vetor; n, tam_seg: longint): longint;
var
    i, j: longint;
begin
    for i := 1 to n - tam_seg + 1 do
    begin
        for j := i + tam_seg to n - tam_seg + 1 do
        begin
            if subsequencias_iguais(v, i, j, tam_seg) then
            begin
                tem_subsequencia_iguais := i;
                exit;
            end;
        end;
    end;
    tem_subsequencia_iguais := 0;
end;

(* programa principal *)
begin
    read(n);
    ler_vetor(v, n);
    pos := 0;
    tamanho_subsequencia := n div 2; // inicia com maior valor possivel
    while (pos = 0) and (tamanho_subsequencia >= 2) do
    begin
         pos := tem_subsequencia_iguais(v, n, tamanho_subsequencia);
         tamanho_subsequencia := tamanho_subsequencia - 1;
    end;
    if pos > 0 then
        writeln(pos, ' ', tamanho_subsequencia + 1)
    else
        writeln('nenhuma');
end.
