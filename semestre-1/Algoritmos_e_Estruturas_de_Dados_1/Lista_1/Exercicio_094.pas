{
Enunciado:
Faça um programa Pascal que leia dois números inteiros, um será o valor de um produto e outro o valor de desconto que esse produto está recebendo.
Imprima quantos reais o produto custa na promoção.

Exemplos:

Entrada 1:
500 50
Saída Esperada 1:
450

Entrada 2:
60000 1
Saída Esperada 2:
59999
}


program promocao;

var 
    produto, desconto,conta : longint;

begin
    read(produto, desconto);
    conta:= produto-desconto;
    write(conta);
end.