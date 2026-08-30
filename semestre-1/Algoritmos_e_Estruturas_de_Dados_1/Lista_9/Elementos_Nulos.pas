{
  Uma matriz quadrada A de ordem n×n é considerada triangular quando:
  - Todos os elementos acima da diagonal principal são zero (matriz triangular inferior), ou
  - Todos os elementos abaixo da diagonal principal são zero (matriz triangular superior).

  Faça um programa em Free Pascal que:
  1. Leia um inteiro positivo n (1 ≤ n ≤ 100).
  2. Leia uma matriz inteira A de ordem n×n, com cada elemento x tal que 0 ≤ x ≤ 100.
  3. Imprima "sim" caso a matriz seja triangular, ou "nao" caso contrário.

  Observação:
  - O programa deve encerrar a execução assim que determinar se a matriz é triangular.

  Exemplos:
  Entrada 1:
  3
  1 9 5
  0 2 4
  0 0 7
  Saída Esperada:
  sim

  Entrada 2:
  3
  1 0 0
  5 2 0
  4 9 3
  Saída Esperada:
  sim

  Entrada 3:
  3
  1 2 3
  4 5 6
  7 8 9
  Saída Esperada:
  nao
}


program teste;
type matriz= array[0..200,0..200] of longint;
var m:matriz;
    tam:longint;


// verifica se é trinangular superior
function trinangular_sup(var m:matriz; var tam:longint):boolean;
var j, verifica:longint;
begin
    j:=1;
    verifica:=1;
    
    while j <= tam do
    begin
        if m[j, 1] = 0 then
            verifica:= verifica+1;
        j:=j+1;
    end;
    
    if verifica=tam then
        trinangular_sup:=true
    else
        trinangular_sup:=false;
end;


//verifica se é triangular inferior
function trinangular_inf(var m:matriz; var tam:longint):boolean;
var j, verifica:longint;
begin
    j:=1;
    verifica:=1;
    
    while j <= tam do
    begin
        if m[1, j] = 0 then
            verifica:= verifica+1;
        j:=j+1;
    end;
    
    if verifica=tam then
        trinangular_inf:=true
    else
        trinangular_inf:=false;
end;

// imprime a matriz na tela
procedure imprime(var m:matriz; var tam:longint);
var i, j:longint;
begin
    for i:=1 to tam do
         for j:= 1 to tam do
            write(m[i, j], ' ');
end;

// lê matriz
procedure le(var m:matriz; var tam:longint);
var i, j:longint;
begin
    for i:=1 to tam do
        for j:= 1 to tam do
            read(m[i,j]);
end;

//principal
begin
    read(tam);
    le(m, tam);
    // se uma das duas for verdade imprime 'sim'.
    if (trinangular_inf(m, tam))or(trinangular_sup(m , tam))then
        writeln('sim')
    else
        writeln('nao');
end.

