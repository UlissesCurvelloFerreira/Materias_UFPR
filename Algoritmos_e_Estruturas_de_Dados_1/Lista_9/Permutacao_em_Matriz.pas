{
  Uma matriz inteira A de ordem n×n é considerada uma matriz de permutação
  se em cada linha e em cada coluna houver n - 1 elementos iguais a 0
  e um único elemento igual a 1.

  Faça um programa em Free Pascal que:
  1. Leia um inteiro positivo n (1 ≤ n ≤ 100).
  2. Leia uma matriz inteira A de ordem n×n, com cada elemento x tal que 0 ≤ x ≤ 100.
  3. Imprima "sim" caso a matriz seja de permutação, ou "nao" caso contrário.

  Observação:
  - O programa deve encerrar a execução assim que descobrir se a propriedade
    definida foi atendida ou não.

  Exemplos:
  Entrada 1:
  3
  1 0 0
  0 1 0
  0 0 1
  Saída Esperada:
  sim

  Entrada 2:
  3
  1 0 0
  1 0 0
  0 1 0
  Saída Esperada:
  nao
}

program teste;
type matriz= array[0..200,0..200] of longint;
var m:matriz;
    num_l, num_c, tam, linha, coluna, controle, funcao:longint;

procedure saida(var num_l, num_c:longint);
begin
    if (num_l=0)and(num_c=0) then
        writeln('sim')
    else if (num_c=1)and(num_l=0)or (num_c=0)and(num_l=1)then
        writeln('estou aqui')
    else
        writeln('nao');
end;

procedure verifica(var m:matriz; var tam, controle, l, c, funcao:longint);
var cont:longint;
begin
    controle:=0;
    cont:=0;
    l:=1;
    c:=1;
    while (l<=tam) and (controle=0) do
    begin
        while (c<=tam) and (controle=0)do
        begin
            if funcao=0 then
            begin
                if (m[l,c] = 1) then
                begin
                    cont:=cont+1;
                    if cont = 2 then
                        controle:=1;
                end; 
                c:=c+1;
            end
            else
            begin
                if (m[c,l] = 1) then
                begin
                    cont:=cont+1;
                    if cont = 2 then
                        controle:=1;
                end; 
                c:=c+1;
            end
        end;
        l:=l+1;
        cont:=0;
        c:=1;
    end;
    funcao:=funcao+1;
end;

procedure le(var m:matriz; var tam:longint);
var i, j:longint;
begin
    for i:=1 to tam do
        for j:= 1 to tam do
            read(m[i,j]);
end;

begin
    read(tam);
    funcao:=0;
    le(m, tam);
    verifica(m, tam, num_l, linha, coluna, funcao);
    verifica(m, tam, num_c, linha, coluna, funcao);
    saida(num_c, num_c);
end.