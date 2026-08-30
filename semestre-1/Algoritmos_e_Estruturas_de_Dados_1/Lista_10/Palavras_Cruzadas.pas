{
  Um jogo de palavras cruzadas pode ser representado por uma matriz A(n × m), onde:
  - 0 indica um quadrado em branco
  - -1 indica um quadrado preto

  Faça um programa em Free Pascal que:
  1. Leia os valores de n e m.
  2. Leia a matriz A de dimensão n×m.
  3. Coloque numerações nos quadrados de início das palavras horizontais e/ou verticais,
     substituindo os zeros correspondentes.
     - Uma palavra deve ter pelo menos duas letras.
     - Palavras horizontais são adicionadas da esquerda para a direita.
     - Palavras verticais são adicionadas de cima para baixo.

  Observação:
  - A numeração deve seguir a ordem de aparecimento das palavras, começando em 1.

  Exemplo de entrada:
  5 8
  0 -1 0 -1 -1 0 -1 0
  0 0 0 0 -1 0 0 0
  0 0 -1 -1 0 0 -1 0
  -1 0 0 0 0 -1 0 0
  0 0 -1 0 0 0 -1 -1

  Saída esperada:
  1 -1 2 -1 -1 3 -1 4
  5 6 0 0 -1 7 0 0
  8 0 -1 -1 9 0 -1 0
  -1 10 0 11 0 -1 12 0
  13 0 -1 14 0 0 -1 -1
}



program PalavrasCruzadas;

var
  n, m: integer;
  A: array[1..100, 1..100] of integer;
  i, j, num: integer;
  iniciH, iniciV: boolean;

begin
  { Leitura das dimensoes }
  read(n);
  read(m);

  { Leitura da matriz }
  for i := 1 to n do
    for j := 1 to m do
      read(A[i][j]);

  { Numeracao: percorre linha a linha, da esquerda para a direita }
  num := 1;

  for i := 1 to n do
    for j := 1 to m do
      if A[i][j] = 0 then
      begin
        { Verifica inicio de palavra horizontal:
          - a esquerda eh borda ou casa preta
          - a direita existe e eh casa livre }
        iniciH := ((j = 1) or (A[i][j-1] = -1))
                  and (j + 1 <= m) and (A[i][j+1] = 0);

        { Verifica inicio de palavra vertical:
          - acima eh borda ou casa preta
          - abaixo existe e eh casa livre }
        iniciV := ((i = 1) or (A[i-1][j] = -1))
                  and (i + 1 <= n) and (A[i+1][j] = 0);

        if iniciH or iniciV then
        begin
          A[i][j] := num;
          inc(num);
        end;
      end;

  { Impressao da matriz resultado }
  for i := 1 to n do
  begin
    for j := 1 to m do
    begin
      if j > 1 then write(' ');
      write(A[i][j]);
    end;
    writeln;
  end;

end.