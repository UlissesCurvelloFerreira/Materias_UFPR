{
Faça um programa Pascal que leia um número inteiro do teclado. 
Se ele estiver entre os valores -15 e 30 (-15 e 30 não estão inclusos), 
imprima seu número oposto, senão imprima o próprio número.

Exemplos:
Entrada 1:
50
Saída Esperada 1:
50

Entrada 2:
-10
Saída Esperada 2:
10

Entrada 3:
23
Saída Esperada 3:
-23
}


program entreValores;

var n: longint;

begin
    read(n);

    if (n > -15) and (n < 30) then
        write(n*-1)
    else
        write(n);
end.
