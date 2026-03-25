{
Enunciado:
Um banco concederá um crédito especial aos seus clientes, mas este crédito será dependente do saldo médio de cada cliente no último ano. Faça um programa Pascal que leia do teclado um valor inteiro que é o saldo médio de um cliente específico e calcule o valor do crédito de acordo com a tabela abaixo. Imprima na tela um inteiro que é o saldo médio lido e outro valor inteiro que é o valor do crédito que pode ser concedido.
Observação: este último valor impresso deverá ser seguido do símbolo "%", a menos da situação em que este crédito é zero, neste caso não deve ser impresso este símbolo.

Tabela de crédito:

Saldo médio       | Percentual
0 a 200           | 0
201 a 400         | 20% do valor do saldo médio
401 a 600         | 30% do valor do saldo médio
acima de 601      | 40% do valor do saldo médio

Exemplos:

Exemplo 1:
150
Saída Esperada 1:
150
0

Exemplo 2:
1000
Saída Esperada 2:
1000
40%
}


program valorCredito;

var salario: longint;

begin
    read(salario);
    if (salario >= 0)and(salario <= 200)then
        begin
            writeln(salario);
            write('0');
        end
    else if (salario >= 201) and (salario <= 400 ) then
        begin
            writeln(salario);
            write('20%');
        end
    else if (salario >= 401) and (salario <= 600 ) then
        begin
            writeln(salario);
            write('30%');
        end
    else 
        begin
            writeln(salario);
            write('40%');
        end;
end.