{
Enunciado:
Faça um programa Pascal que, dados dois números inteiros positivos, imprima quantas vezes o segundo divide exatamente o primeiro. Se o segundo não divide o primeiro o número de vezes é zero. Por exemplo, 72 pode ser dividido exatamente por 3 duas vezes. Use somente operadores inteiros.

Exemplos:

Entrada 1:
72 3

Saída Esperada 1:
2
}


program ex50;

var a, b, divi, contador:longint;

begin
    read(a, b);
    contador:= 0;
    while a mod b = 0 do
    begin
        divi:= a div b;
        a:= divi;
        contador:= contador + 1;
    end;
    write(contador);
end.
