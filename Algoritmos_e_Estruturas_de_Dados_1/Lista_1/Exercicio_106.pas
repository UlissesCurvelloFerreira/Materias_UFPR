
{
Faça um programa Pascal que leia um número inteiro do teclado e imprima o cubo do número caso ele seja positivo ou igual a zero e o quadrado do número caso ele seja negativo.

Exemplos:
Entrada 1:
0
Saída Esperada 1:
0

Entrada 2:
4
Saída Esperada 2:
64

Entrada 3:
-5
Saída Esperada 3:
25
}

program cuboParImpar;

var n, cubo, quadrado: longint;

begin
    read(n);
    quadrado:= n*n;
    cubo:= n*n*n;
    if n >= 0 then
        write(cubo)
    else
        write(quadrado);
end.