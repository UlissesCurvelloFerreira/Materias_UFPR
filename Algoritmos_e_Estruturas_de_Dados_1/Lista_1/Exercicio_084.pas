{
Faça um programa Pascal que leia dois números inteiros e imprima a média aritmética inteira entre eles.

Exemplos:
Entrada 1:
10 20
Saída Esperada 1:
15

Entrada 2:
750 1500
Saída Esperada 2:
1125

Entrada 3:
8900 12300
Saída Esperada 3:
10600
}


program mediaAritimetica;

var 
    num1, num2, media: longint;

begin
    read(num1, num2);
    media:=(num1+num2);
    write(round(media/2));
end.