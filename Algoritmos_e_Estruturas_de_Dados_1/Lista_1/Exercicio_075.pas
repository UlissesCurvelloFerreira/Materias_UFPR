{
Enunciado:
Considere que o número de uma placa de veículo é composto por quatro algarismos. Faça um programa Pascal que leia um número inteiro que tenha exatamente 4 dígitos do teclado e imprima o algarismo correspondente à casa das unidades.
Use o operador MOD.

Exemplos:

Entrada 1:
2569
Saída Esperada 1:
9

Entrada 2:
1000
Saída Esperada 2:
0
}


program mostraUnidade;
var
   num, conta: longint;

begin
    read(num);
    conta:=num mod 10;
    write(conta);
end.