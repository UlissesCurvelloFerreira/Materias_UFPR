{
  Faça um programa em Free Pascal que:
  1. Leia dois números naturais n e m (0 < n, m ≤ 100), com m < n.
  2. Leia duas sequências de números naturais:
     - A primeira sequência contém n elementos.
     - A segunda sequência contém m elementos.
  3. Determine quantas vezes a segunda sequência ocorre como subsequência contígua dentro da primeira sequência.
  4. Imprima a quantidade de ocorrências.

  Observações:
  - A sequência deve ser contígua, ou seja, os elementos devem aparecer na mesma ordem.
  - Cada ocorrência sobrepõe ou não outras ocorrências de acordo com a posição.

  Exemplo de entrada 1:
  7
  2
  18 23 6 14 6 31 13
  12 20
  Saída esperada: 0

  Exemplo de entrada 2:
  9
  4
  18 23 6 14 6 18 23 6 14
  18 23 6 14
  Saída esperada: 2

  Exemplo de entrada 3:
  30
  3
  2 4 2 1 6 1 7 2 9 10 2 4 2 1 8 11 12 13 2 7 1 5 6 1 3 2 4 2 4 2
  2 4 2
  Saída esperada: 4
}


program ocorrencias;
type matriz = array[1..200,1..200] of integer;
var
    matrizSequencias: matriz;
    x, y: integer;


// Adiciona as sequências de números
procedure adicionaSequencias(var m: matriz; tam1, tam2: integer);
var i, num: integer;
begin
    for i:=1 to tam1 do
    begin
        read(num);
        m[1][i] := num; 
    end;
    for i:=1 to tam2 do
    begin
        read(num);
        m[2][i] := num; 
    end;
end;


// Imprime matriz
procedure imprimeMatriz(m: matriz; lin, col: integer);
var i, j: integer;
begin
    for i:=1 to lin do
    begin
        for j:=1 to col do
        begin
            write(m[i][j], ' ');
        end;
        writeln();
    end;
end;


// Verifica quantas vezes a sequência de uma linha se repete na outra
function verificaRepeticao(m: matriz; tam1, tam2: integer):integer;
var 
    i, c: integer;
    validador: boolean;
begin
    verificaRepeticao := 0;
    for i:=1 to (tam1 - tam2 + 1) do
    begin
        validador := true;
        c := 1;
        while(c <= tam2) and (validador) do
        begin
            if(m[2][c] <> m[1][i + c - 1]) then validador := false;
            c := c + 1;
        end;
        if validador then verificaRepeticao := verificaRepeticao + 1;
    end;
end;


// Programa principal
begin
    read(x, y);
    adicionaSequencias(matrizSequencias, x, y);
    writeln(verificaRepeticao(matrizSequencias, x, y));
end.