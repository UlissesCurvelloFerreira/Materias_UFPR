{
Enunciado:
Faça uma função que receba como parâmetro um número inteiro garantidamente binário e o converta para decimal. Teste sua função usando este código:

program converte;
var n: longint;

(* coloque aqui o codigo da sua funcao que converte para decimal *)

begin
    read (n);
    writeln (converte_em_decimal (n));
end.

Exemplos de entradas
10001
1010

Saídas esperadas
17
10
}


program converte;
var n:longint;
(* coloque aqui o codigo da sua funcao que converte para decimal *)

function converte_em_decimal(num:longint):longint;
var soma, i, conta:longint;
begin
    i:=1;
    soma:=0;
    while num <> 0 do
    begin
        conta:=(num mod 10);
        soma:=soma+(conta*i);
        num:=num div 10;
        i:=i*2;
    end;
    converte_em_decimal:=soma;
end;
begin
    read (n);
    writeln(converte_em_decimal(n));
end.