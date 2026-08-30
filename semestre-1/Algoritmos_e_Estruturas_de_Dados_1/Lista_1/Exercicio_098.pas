{
Faça um programa Pascal que leia um número real do teclado e imprima a terça parte deste número com duas casas decimais.

Exemplos:
Entrada 1:
3
Saída Esperada 1:
1.00

Entrada 2:
10
Saída Esperada 2:
3.33

Entrada 3:
90
Saída Esperada 3:
30.00
}


program tercaParte;


var num, terca: real;

begin

    read(num);
    terca:= num/3;
    write(terca:0:2);
end.