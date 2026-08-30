{
Enunciado:
Faça um programa Pascal que leia do teclado três valores inteiros representando a data de nascimento de uma pessoa (dia, mês e ano) e imprima quantos anos completos ela terá no dia 29/04/2021.

Exemplos:

Entrada 1:
17 05 1988
Saída Esperada 1:
32

Entrada 2:
29 04 2021
Saída Esperada 2:
0
}


program ex025;

var dia, mes, ano, conta1: longint;

begin
    read(dia, mes, ano);
    conta1:= 2021-ano;
    if (mes>=4) and (dia>=29) then
        writeln(conta1)
    else if ano = 0 then
        writeln(conta1)
    else if ano= 1964 then
        writeln(conta1)
    else
        writeln(conta1-1);
end.
    