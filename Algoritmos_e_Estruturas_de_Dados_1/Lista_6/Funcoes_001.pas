{
Faça uma função que receba como parâmetros dois números inteiros não nulos e retorne true se um for o contrário do outro e false em caso contrário. Teste sua função usando este código:

program contrario;
var n,m: longint;

(* coloque aqui o codigo da sua funcao *)

begin
read (n,m);
if contrario (n,m) then
writeln (n,' eh o contrario de ',m)
else
writeln (n,' nao eh o contrario de ',m);
end.

Exemplos de entradas
123 321
123 231

Saídas esperadas
123 eh o contrario de 321
123 nao eh o contrario de 231
}


program contrario;
var n,m: longint;

(* coloque aqui o codigo da sua funcao *)
function contrario(n1, n2:longint):boolean;
var conta, inv:longint;
begin
    inv:=0;
    while(n1 <>0)do
    begin
        conta:=n1 mod 10;
        //multiolica o inv assim realiza a multiplicação no inv 
        //realizando a conta e fazendo com q o número saia invertido.
        inv:=inv*10+(conta);
        n1:=n1 div 10;
    end;
    if inv = n2 then
        contrario:=true
    else
        contrario:=false;
end;
begin
    read (n,m);
    if contrario(n,m)then
        writeln(n,' eh o contrario de ',m)
    else
        writeln(n,' nao eh o contrario de ',m);
end.