{
Enunciado:
Faça um programa Pascal que leia do teclado uma sequência de números inteiros até que seja lido um número que seja o dobro ou a metade do anteriormente lido. O programa deve imprimir na saída três números inteiros que são, respectivamente, a quantidade de números lidos, a soma dos números lidos e os dois valores que forçaram a parada do programa.

Exemplos:

Entrada 1:
-549 -716 -603 -545 -424 -848

Saída Esperada 1:
6 -3685 -424 -848

Entrada 2:
-549 -716 -603 -545 -424 646 438 892 964 384 192

Saída Esperada 2:
11 679 384 192
}


program ex008;
var
    qt, soma, num, numtemp: integer;

begin
    numtemp := 0;
    soma := 0;
    qt := 1;
    read(num);
    while(((num <> (numtemp * 2)) and (num <> (numtemp / 2))) or (qt = 1)) do
    begin
        numtemp := num;
        qt := qt + 1;
        soma := soma + num;
        read(num);
    end;
    soma := soma + num;
    writeln(qt, ' ', soma, ' ', numtemp, ' ', num);
end.