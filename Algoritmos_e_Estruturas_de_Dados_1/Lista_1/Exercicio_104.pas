{ 
Faça um programa Pascal que leia do teclado dois números inteiros e imprima qual é o menor valor entre eles.

Exemplos:
Entrada 1:
5 4
Saída Esperada 1:
4

Entrada 2:
-3 -4
Saída Esperada 2:
-4

Entrada 3:
6 15
Saída Esperada 3:
6
}


program qualMaior;

var n1, n2 : longint;

begin
    read(n1, n2);
    if n1 > n2 then
        write(n2)
    else
        write(n1);
end.