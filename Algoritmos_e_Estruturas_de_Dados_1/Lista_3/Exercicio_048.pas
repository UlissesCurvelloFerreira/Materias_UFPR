{
Enunciado:
Faça um programa Pascal que leia do teclado dois números inteiros positivos ímpares A e B onde (A ≤ B) e imprima o produto dos números ímpares de A até B.
Isto é, calcule:
A (A + 2) (A + 4) * ... * B

Imprima "erro" caso o número lido não satisfaça as condições. Caso contrário imprima o resultado do cálculo.

Exemplos:

Entrada 1:
3 5
Saida Esperada 1:
15

Entrada 2:
7 15
Saida Esperada 2:
135135
}


program ex048;

var a, b, conta :longint;

begin
    read(a, b);
    conta:=1;
    if (a mod 2 <> 0) and (b mod 2 <> 0) and (a<=b) then
    begin
        while a<=b do
        begin
        conta:= conta*a;
        a:=a+2;
        end;
        write(conta);
    end
    else
        write('erro');
end.
