{
Enunciado:
Faça um programa Pascal que leia do teclado um número inteiro positivo. Seu programa deve imprimir uma mensagem indicando em qual das seguintes situações esse número se enquadra:

- Múltiplo exclusivamente de 7: imprimir "Multiplo exclusivamente de 7."
- Múltiplo exclusivamente de 11: imprimir "Multiplo exclusivamente de 11."
- Múltiplo de 7 e de 11: imprimir "Multiplo de 7 e de 11."
- Não é múltiplo nem de 7 nem de 11: imprimir "Nao e multiplo nem de 7 nem de 11."

Exemplos:

Entrada 1:
210
Saída Esperada 1:
Multiplo exclusivamente de 7.

Entrada 2:
200
Saída Esperada 2:
Nao e multiplo nem de 7 nem de 11.
}


program multiplo;

var num, contaUm, contaDois:longint;

begin
    read(num);
    contaUm:= num mod 7;
    contaDois:= num mod 11;
    if (contaUm = 0) and (contaDois <> 0) then
        writeln('Multiplo exclusivamente de 7.')
    else if (contaUm <> 0) and (contaDois = 0) then
        writeln('Multiplo exclusivamente de 11.')
    else if (contaUm = 0) and (contaDois = 0) then
        writeln('Multiplo de 7 e de 11.')
    else
        writeln('Nao e multiplo nem de 7 nem de 11.');
end.