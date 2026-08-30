{
  Faça um programa em Free Pascal que:
  1. Leia um número natural n (0 < n ≤ 100).
  2. Leia uma sequência de n números inteiros.
  3. Determine o valor da subsequência contígua que maximize a soma de seus elementos.
  4. Imprima o valor máximo obtido.

  Observações:
  - A subsequência deve ser contígua dentro do vetor.
  - O valor máximo da soma é obtido somando os elementos dessa subsequência.
  - Idealmente, o programa deve minimizar o número de somas calculadas, evitando somar
    duas vezes sequências já somadas.

  Exemplo de entrada:
  12
  5 2 -2 -7 3 14 10 -3 9 -6 4 1

  Saída esperada:
  33
}


program teste;

type vetor= array[1..100] of longint;

var v:vetor;
    tam, somamax:longint;


procedure maximize (var v:vetor; var tam, somamax:longint);
var i, j, somapox:longint;
begin
    for i:=1 to tam do
    begin
        j:=i;
        somapox:=0;
        for j:=j to tam do
        begin
            if (j=1) and (i=1)then
            begin
                somapox:=v[i];
                somamax:=somapox;
            end
            else
            begin
                somapox:=somapox+v[j];
                if somapox > somamax then
                    somamax:=somapox;
            end;
        end;
    end;
end;

procedure leitor(var v:vetor; var tam:longint);
var i:longint;
begin
    for i:=1 to tam do
        read(v[i]);
end;

begin
    read(tam);
    leitor(v, tam);
    maximize(v, tam, somamax);
    write(somamax);
end.