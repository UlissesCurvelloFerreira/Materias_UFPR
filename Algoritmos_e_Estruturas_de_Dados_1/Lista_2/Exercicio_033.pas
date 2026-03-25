{
Enunciado:
Faça um programa Pascal que leia dois números inteiros representando respectivamente o número de lados de um polígono regular e a medida do lado. Seu programa deve fazer o seguinte:

- Se o número de lados for 3, imprima TRIANGULO e o valor do seu perímetro;
- Se o número de lados for 4, imprima QUADRADO e o valor da sua área;
- Se o número de lados for 5, imprima PENTAGONO;
- Se o número de lados for menor que 3, imprima a mensagem "ERRO";
- Se o número de lados for maior que 5, imprima a mensagem "ERRO".

Exemplos:

Exemplo 1:
3 10
Saída Esperada 1:
TRIANGULO 30

Exemplo 2:
6 20
Saída Esperada 2:
ERRO
}

program formas;

var lados, media: longint;

begin
    read(lados, media);
    
    if lados = 3 then
        write('TRIANGULO ', media * 3)
    else if lados = 4 then
        write('QUADRADO ', media * media)
    else if lados = 5 then
        write('PENTAGONO ')
    else if lados < 3 then
        write('ERRO')
    else
        write('ERRO');
end.