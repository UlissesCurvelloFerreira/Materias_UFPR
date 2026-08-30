{
Enunciado:
Sabendo-se que a água se solidifica a zero grau Celsius, ou a 32 Fahrenheit, e que entra em ebulição a 100 graus Celsius ou 212 Fahrenheit, faça um programa Pascal que obtenha do teclado um inteiro que é o valor de temperatura em Fahrenheit e imprima na tela o valor correspondente em Celsius e também imprima na tela uma mensagem "solido", "liquido" ou "gasoso" indicando respectivamente se a água está no estado sólido, líquido ou gasoso.

A fórmula de conversão entre graus Celsius e Fahrenheit é:
C = (F - 32) * 5 / 9

Exemplos:

Entrada 1:
45
Saída Esperada 1:
7.22
liquido

Entrada 2:
240
Saída Esperada 2:
115.56
gasoso
}


program grausTemperatura;

var num, muda : real;

begin
    read(num);
    muda:= ((5*num)-160)/9;
    writeln(muda:0:2);
    if muda < 1 then
        write('solido')
    else if muda > 99 then
        write('gasoso')
    else
        write('liquido');
end.