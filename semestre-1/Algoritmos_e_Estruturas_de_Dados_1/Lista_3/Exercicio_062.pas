{
Enunciado:
Faça um programa Pascal que receba uma sequência de números reais terminada em zero representando o saldo bancário de alguns clientes de um banco e imprima aqueles que são negativos. O valor zero serve para indicar o final da entrada de dados e não deve ser processado.

Exemplos:

Entrada 1:
832.47
215.25
-1987.11
19.00
-45.38
0

Saída Esperada 1:
-1987.11
-45.38
}


program arranjos;

var saldo:real;
begin
    read(saldo);
    
    while saldo <> 0 do
        begin
            if saldo < 0 then
                writeln(saldo:0:2);
            read(saldo);
        end;
end.