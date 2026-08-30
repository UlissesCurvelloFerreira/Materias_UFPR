{
Enunciado:
Um vendedor necessita de um programa que calcule o preço total devido por um cliente que comprou um produto em sua loja. Faça um programa Pascal que receba dois números inteiros que são, respectivamente, o código do produto e a quantidade comprada. Imprima na tela o preço total com duas casas decimais, usando a tabela abaixo.
Caso o código não exista o programa deve imprimir ERRO.

Código do Produto | Preço unitário
1001              | 5,32
1324              | 6,45
6548              | 2,37
987               | 5,32
7623              | 6,45

Exemplos:

Exemplo 1:
1324 6
Saída Esperada 1:
38.70

Exemplo 2:
987 9
Saída Esperada 2:
47.88
}


program qualValor;

var cod, quant: real;

begin
    read(cod, quant);

    if cod = 1001 then
        write((quant*5.32):0:2)
    else if cod = 1324 then
        write((quant*6.45):0:2)
    else if cod = 6548 then
        write((quant*2.37):0:2)
    else if cod = 987 then
        write((quant* 5.32):0:2)
    else if cod = 7623 then
        write((quant*6.45):0:2)
    else
        write('ERRO');
end.