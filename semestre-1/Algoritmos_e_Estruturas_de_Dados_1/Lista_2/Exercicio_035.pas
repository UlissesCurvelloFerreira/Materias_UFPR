{
Enunciado:
Faça um programa Pascal que leia do teclado um valor real que representa o salário mensal de uma pessoa. Seu programa deve imprimir o valor do imposto de renda (IR) mensal, em reais, de acordo com a tabela de 2009, que está abaixo.

Se o salário digitado for menor que o salário mínimo de R$ 540,00, o programa deve imprimir "NAO".

Tabela de IR 2009:

- Salário menor ou igual a 1424,00: 0%;
- Salário maior que 1424,00 e menor ou igual a 2150,00: 7.5%;
- Salário maior que 2150,00 e menor ou igual a 2866,00: 15%;
- Salário maior que 2866,00 e menor ou igual a 3582,00: 22.5%;
- Salário maior que 3582,00: 27.5%.

Junto com o valor do IR mensal, o programa deve imprimir a faixa (1, 2, 3, 4 ou 5) correspondente ao salário.

Exemplos:

Entrada 1:
500.00
Saída Esperada 1:
NAO

Entrada 2:
2300.00
Saída Esperada 2:
3 345.00
}


program rendaIR;

var salario:real;

begin
    read(salario);
    
    if salario < 540.00 then
    writeln('NAO')
    else if salario <= 1424.00 then
    writeln('1 ', salario*0:0:2)
    else if (salario > 1424.00)and(salario <= 2150.00)then
    writeln('2 ', salario*0.075:0:2)
    else if (salario > 2150.00)and(salario <= 2866.00)then
    writeln('3 ', salario*0.15:0:2)
    else if (salario > 2866.00)and(salario <= 3582.00)then
    writeln('4 ', salario*0.225:0:2)
    else
    writeln('5 ', salario*0.275:0:2);
    
end.