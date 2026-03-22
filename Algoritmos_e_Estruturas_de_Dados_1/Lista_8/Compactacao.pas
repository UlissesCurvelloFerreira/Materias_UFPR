{
  Faça um programa em Free Pascal que:
  1. Leia diversas linhas de entrada.
     - Linhas ímpares contêm um número n (0 ≤ n ≤ 100), que indica o tamanho da sequência na linha seguinte.
     - Linhas pares contêm a sequência de n números inteiros.
  2. Quando uma linha ímpar contiver o valor zero, a entrada termina.
  3. O programa deve imprimir todas as sequências originais e também as sequências compactadas,
     removendo elementos repetidos de cada sequência, mantendo a ordem original.

  Notação de saída:
  - O: sequência original
  - C: sequência compactada

  Exemplo de entrada:
  5
  2 4 7 -1 2
  3
  1 1 1
  7
  3 4 5 3 7 5 1
  0

  Saída esperada:
  O: 2 4 7 -1 2
  C: 2 4 7 -1
  O: 1 1 1
  C: 1
  O: 3 4 5 3 7 5 1
  C: 3 4 5 7 1
}


program compactacao;
type 
    vetor = array[-200..200] of integer;
    matriz = array[1..200,1..200] of integer;
var
    matrizDados: matriz;
    vetorDigitos: vetor;


// Insere linhas com quantidades de colunas variadas
procedure insereDadosMatriz(var m: matriz);
var qt, i, j, num: integer;
begin
    i := 1;
    read(qt);
    m[i][1] := qt;
    i := i + 1;
    while(qt <> 0) do
    begin
        for j:=1 to qt do
        begin
            read(num);
            m[i][j] := num;
        end;
        read(qt);
        m[i + 1][1] := qt;
        i := i + 2;
    end;
    
end;


// Imprime resultado
procedure imprimeResultado(m: matriz; var v_dig: vetor);
var i, lin: integer;
begin
    lin := 1;
    while(m[lin][1] > 0) do
    begin
        write('O: ');
        for i:=1 to m[lin][1] do
        begin
            write(m[lin + 1][i], ' ');
        end;
        writeln();
        write('C: ');
        for i:=1 to m[lin][1] do
        begin
            v_dig[m[lin + 1][i]] := v_dig[m[lin + 1][i]] + 1;
            if(v_dig[m[lin + 1][i]] = 1) then write(m[lin + 1][i], ' ');
        end;
        for i:=1 to m[lin][1] do
        begin
            v_dig[m[lin + 1][i]] := 0
        end;
        writeln();
        lin := lin + 2;
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


// Programa principal
begin
    insereDadosMatriz(matrizDados);
    imprimeResultado(matrizDados, vetorDigitos);
end.   