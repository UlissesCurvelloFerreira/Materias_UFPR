{
  Uma matriz quadrada inteira é chamada de quadrado mágico se:
  - A soma dos elementos de cada linha,
  - A soma dos elementos de cada coluna,
  - A soma dos elementos das diagonais principal e secundária
  forem todas iguais.

  Faça um programa em Free Pascal que:
  1. Leia um valor inteiro n representando o tamanho da matriz.
  2. Leia uma matriz A de dimensão n×n.
  3. Verifique se a matriz é um quadrado mágico.
  4. Imprima "sim" caso a matriz seja um quadrado mágico, ou "não" caso contrário.

  Exemplo de entrada:
  3
  8 0 7
  4 5 6
  3 10 2

  Saída esperada:
  sim
}

program QuadradoMagico;

var
  n: integer;
  A: array[1..100, 1..100] of integer;
  i, j: integer;
  alvo, soma: integer;
  magico: boolean;

begin
  read(n);

  for i := 1 to n do
    for j := 1 to n do
      read(A[i][j]);

  { Soma da primeira linha como valor de referencia }
  alvo := 0;
  for j := 1 to n do
    alvo := alvo + A[1][j];

  magico := true;

  { Verifica todas as linhas }
  for i := 1 to n do
  begin
    soma := 0;
    for j := 1 to n do
      soma := soma + A[i][j];
    if soma <> alvo then
      magico := false;
  end;

  { Verifica todas as colunas }
  for j := 1 to n do
  begin
    soma := 0;
    for i := 1 to n do
      soma := soma + A[i][j];
    if soma <> alvo then
      magico := false;
  end;

  { Verifica diagonal principal }
  soma := 0;
  for i := 1 to n do
    soma := soma + A[i][i];
  if soma <> alvo then
    magico := false;

  { Verifica diagonal secundaria }
  soma := 0;
  for i := 1 to n do
    soma := soma + A[i][n - i + 1];
  if soma <> alvo then
    magico := false;

  if magico then
    writeln('sim')
  else
    writeln('nao');

end.