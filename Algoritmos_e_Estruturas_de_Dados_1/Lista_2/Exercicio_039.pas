{
Enunciado:
Faça um programa Pascal que receba um número inteiro positivo N e calcule o produto dos N primeiros números pares positivos. Ao final, imprima um inteiro que é este produto. Para esse exercício, considere o primeiro número par como sendo 2.

Exemplos:

Entrada 1:
2
Saída Esperada 1:
8

Entrada 2:
4
Saída Esperada 2:
384
}


program nPositivos;

var num, i, conta, valor:longint;

begin
    read(num);
    valor:=1;
    conta:=1;
    while i < num do
        begin
            conta:=conta*(valor*2);
            valor:=valor+1;
            i:=i+1;
        end;
    writeln(conta);
end.