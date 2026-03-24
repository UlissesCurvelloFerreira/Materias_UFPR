{
Faça uma função que receba como parâmetro um número inteiro e teste se ele é um número binário. Se ele for binário, imprima sim senão imprima nao. Teste sua função usando este código:

program testa_binario;
var n: longint;

(* coloque aqui o codigo da sua funcao que testa se eh binario *)

begin
    read (n);
    if eh_binario (n) then
        writeln ('sim')
    else
        writeln ('nao');
end.

Exemplos de entradas
10001
1020

Saídas esperadas
sim
nao
}


program testa_binario;
var n: longint;

(* coloque aqui o codigo da sua funcao que testa se eh binario *)
function eh_binario(num:longint):longint;
var i:longint;
begin
    i:=1;
    while(num > 0) and (i=1)do
    begin
        if(num mod 10 = 0)or(num mod 10 =1)then
        begin
        num:=num div 10;
        i:=1;
        end
        else
        i:=0;
    end;
    
    if i = 1 then
        eh_binario:=1
    else 
        eh_binario:=0;
end;

begin
    read(n);
    if eh_binario(n) = 1 then
        writeln ('sim')
    else
        writeln ('nao');
end.
