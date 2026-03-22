{
  Dada uma matriz quadrada A de dimensão n×n, uma submatriz quadrada
  é considerada um quadrado mágico se:
  - A soma dos elementos de cada linha,
  - A soma dos elementos de cada coluna,
  - A soma dos elementos das diagonais principal e secundária
  forem todas iguais.

  Neste exercício, queremos contar quantas submatrizes quadradas não triviais
  (ou seja, de tamanho ≥ 2×2) formam quadrados mágicos dentro da matriz fornecida.

  Faça um programa em Free Pascal que:
  1. Leia um inteiro n representando o tamanho do lado da matriz.
  2. Leia uma matriz A de dimensão n×n.
  3. Verifique todas as submatrizes quadradas de tamanho ≥ 2×2.
  4. Conte e imprima quantas dessas submatrizes são quadrados mágicos.

  Exemplo de entrada:
  6
  2 7 6 6 7 2
  9 5 1 1 5 9
  4 3 8 8 3 4
  4 9 2 2 9 4
  3 5 7 7 5 3
  8 1 6 6 1 8

  Saída esperada:
  5
}


program QuadradoMagico2;

var
  n: integer;
  A: array[1..100, 1..100] of integer;
  i, j: integer;
  sz, li, lj: integer;
  alvo, soma: integer;
  magico: boolean;
  total: integer;

begin
  read(n);

  for i := 1 to n do
    for j := 1 to n do
      read(A[i][j]);

  total := 0;

  { Testa todas as submatrizes quadradas de tamanho sz x sz (sz >= 2) }
  for sz := 2 to n do
    for li := 1 to n - sz + 1 do
      for lj := 1 to n - sz + 1 do
      begin
        { Soma da primeira linha da submatriz como valor de referencia }
        alvo := 0;
        for j := lj to lj + sz - 1 do
          alvo := alvo + A[li][j];

        magico := true;

        { Verifica todas as linhas da submatriz }
        for i := li to li + sz - 1 do
        begin
          soma := 0;
          for j := lj to lj + sz - 1 do
            soma := soma + A[i][j];
          if soma <> alvo then
            magico := false;
        end;

        { Verifica todas as colunas da submatriz }
        for j := lj to lj + sz - 1 do
        begin
          soma := 0;
          for i := li to li + sz - 1 do
            soma := soma + A[i][j];
          if soma <> alvo then
            magico := false;
        end;

        { Verifica diagonal principal da submatriz }
        soma := 0;
        for i := 0 to sz - 1 do
          soma := soma + A[li + i][lj + i];
        if soma <> alvo then
          magico := false;

        { Verifica diagonal secundaria da submatriz }
        soma := 0;
        for i := 0 to sz - 1 do
          soma := soma + A[li + i][lj + sz - 1 - i];
        if soma <> alvo then
          magico := false;

        if magico then
          inc(total);
      end;

  writeln(total);

end.