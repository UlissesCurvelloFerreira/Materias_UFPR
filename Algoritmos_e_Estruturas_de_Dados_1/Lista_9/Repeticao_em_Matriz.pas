{
  Faça um programa em Free Pascal que:
  1. Leia dois inteiros positivos m e n (1 ≤ m, n ≤ 100).
  2. Leia uma matriz A de dimensão m×n, com cada elemento x tal que 1 ≤ x ≤ 1000.
  3. Imprima "sim" se houver elementos repetidos na matriz, caso contrário imprima "nao".

  Observação:
  - O programa deve encerrar a execução assim que detectar qualquer elemento repetido.

  Exemplos:
  Entrada 1:
  3 3
  1 2 3
  4 5 6
  7 8 9
  Saída Esperada:
  nao

  Entrada 2:
  3 4
  1 2 3 4
  4 5 6 7
  7 8 9 10
  Saída Esperada:
  sim
}


program teste;
type matriz= array[1..200,1..200] of longint;
type vetor= array[1..200] of longint;

var l,c,ip:longint;
    m:matriz;
    v:vetor;
    
//Vê se repete.
procedure repete(var v:vetor; var ip:longint);
var i, ve:longint;
begin
    ve:=0;
    for i:=1 to ip do
        if v[i]>1 then
            ve:=1;
    if ve=1 then
        writeln('sim')
    else
        writeln('nao');
end;

// Coloca a matriz em um vetor.
procedure incrmenta(var v:vetor; var valor:longint);
begin
    v[valor]:=v[valor]+1;
end;

// Lê os elementos da matriz.
procedure le(var m:matriz; var v:vetor; var l,c,ip:longint);
var i, j:longint;
begin
    ip:=0;
    for i:=1 to l do
        for j:=1 to c do
        begin
            ip:=ip+1;
            read(m[i,j]);
            incrmenta(v,m[i,j]);
        end;
end;

//Principal.
begin
    read(l,c);
    le(m, v, l, c, ip);
    repete(v, ip);
end.