{
Faça um programa Pascal que leia do teclado dois valores inteiros x e y, e em seguida calcule e imprima o valor da seguinte expressão:
3*x + x*y

Exemplos:
Entrada 1:
4 3
Saída Esperada 1:
24

Entrada 2:
5 2
Saída Esperada 2:
15
}


program calculando;

var 
    num1, num2, calculo: longint;

begin
    read(num1, num2);
    calculo:= (num1*num1*num1) + (num1*num2);
    write(calculo);
end.