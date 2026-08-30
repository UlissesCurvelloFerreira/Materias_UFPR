{
Enunciado:
Uma empresa concederá um aumento de salário aos seus funcionários, mas este aumento será de acordo com o cargo que cada um ocupa. A tabela abaixo contém os códigos, o cargo e o percentual de aumento correspondente.
Faça um programa Pascal que leia dois valores do teclado, o primeiro é um número real que informa o salário de um funcionário e o segundo é um número inteiro que informa o código do cargo dele. Calcule o valor do novo salário e o imprima na tela com duas casas decimais.
Se o cargo do funcionário não estiver na tabela, ele deverá receber 40% de aumento. Imprima o valor do salário antigo, o do novo salário e a diferença entre eles, nesta ordem, em 3 linhas, todos eles sempre valores reais com duas casas decimais.

Tabela de cargos:

Código | Cargo       | Percentual
101    | Gerente     | 10%
102    | Engenheiro  | 20%
103    | Técnico     | 30%

Exemplos:

Exemplo 1:
2500 101
Saída Esperada 1:
2500.00
2750.00
250.00

Exemplo 2:
5000 102
Saída Esperada 2:
5000.00
6000.00
1000.00
}


program aumentoSalario;

var salario, cargo, antigo, novo, reajuste: real;

begin
    read(salario, cargo);
    if cargo = 101 then
        begin
            writeln(salario:0:2);
            reajuste:=salario * 0.1;
            novo:=salario+reajuste;
            writeln(novo:0:2);
            writeln(reajuste:0:2);
            
        end
    else if cargo = 102  then
        begin
            writeln(salario:0:2);
            reajuste:=salario * 0.2;
            novo:=salario+reajuste;
            writeln(novo:0:2);
            writeln(reajuste:0:2);
        end
    else if cargo = 103 then
        begin
            writeln(salario:0:2);
            reajuste:=salario * 0.3;
            novo:=salario+reajuste;
            writeln(novo:0:2);
            writeln(reajuste:0:2);
        end
    else 
        begin
            writeln(salario:0:2);
            reajuste:=salario * 0.4;
            novo:=salario+reajuste;
            writeln(novo:0:2);
            writeln(reajuste:0:2);
        end;
end.