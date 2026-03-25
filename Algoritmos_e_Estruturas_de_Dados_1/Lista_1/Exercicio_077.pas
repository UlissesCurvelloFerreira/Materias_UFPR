{
Enunciado:
Considere que o número de uma placa de veículo é composto por quatro algarismos. Faça um programa Pascal que leia um número inteiro que tenha exatamente 4 dígitos do teclado e imprima o algarismo correspondente à casa das centenas. Use os operadores DIV e MOD.

Exemplos:

Entrada 1:
2500
Saída Esperada 1:
5

Entrada 2:
2031
Saída Esperada 2:
0

Entrada 3:
6975
Saída Esperada 3:
9
}


program mostraCentena;
var
   num, contaUm, contaDois: longint;

begin
    read(num);
    contaUm:=num div 100;
    contaDois:= contaUm mod 10;
    write(contaDois);
end.