{
Enunciado:
Faça um programa Pascal que leia do teclado um inteiro positivo N diferente de zero. Calcule e imprima um inteiro que é a soma dos N primeiros cubos.

Soma = Σ i=1^N i^3 = 1^3 + 2^3 + ... + N^3

Imprima "erro" caso o número lido não satisfaça as condições. Em caso contrário imprima o resultado do cálculo.

Exemplos:

Entrada 1:
3
Saída Esperada 1:
36

Entrada 2:
22
Saída Esperada 2:
64009
}


program ex051;

var n, conta:longint;

begin
    read(n);
    conta:=0;
    if (n > 0) and (n<>0) then
    begin
        while n <> 0 do
        begin
            conta:=conta+(n*n*n);
            n:=n-1;
        end;
    write(conta);
    end
    else
        write('erro');
    
end.

