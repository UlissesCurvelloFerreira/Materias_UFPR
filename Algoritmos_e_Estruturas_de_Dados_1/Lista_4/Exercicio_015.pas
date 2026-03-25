{
Enunciado:
Se multiplicarmos 37 por alguns números, obteremos números cujos algarismos, quando somados, resultam no mesmo número que foi multiplicado pelo 37. Por exemplo, se tomarmos o número 15, multiplicando-o por 37, obtemos 555. Somando-se 5 + 5 + 5 resulta em 15.

Faça um programa Pascal que leia um número inteiro positivo do teclado, calcule o resultado da multiplicação por 37, some os algarismos do resultado, compare essa soma com o número lido e imprima "SIM" se há coincidência ou "NAO" se não há coincidência.

Exemplos:

Entrada 1:
15
Saída Esperada 1:
SIM

Entrada 2:
26
Saída Esperada 2:
NAO
}


program ex015;
var
    num, mult, soma, form: integer;

begin
    soma := 0;
    read(num);
    form := 1;
    mult := num * 37;
    while(mult div form) <> 0 do
    begin
        soma := soma + (mult mod 10) * form;
        mult := mult div 10;
    end;
    if (soma = num) then 
    writeln('SIM')
    else 
    writeln('NAO');
end.