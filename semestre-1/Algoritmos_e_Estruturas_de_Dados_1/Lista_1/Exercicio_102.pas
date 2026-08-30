{
Enunciado:
Faça um programa Pascal que, dado um número inteiro de três dígitos lido do teclado, construa um número inteiro de quatro dígitos com as seguintes regras:
- os três primeiros dígitos, contados da esquerda para a direita, são iguais aos do número dado;
- o quarto dígito é o de controle calculado da seguinte forma:
  primeiro dígito + 3*segundo dígito + 5*terceiro dígito
O dígito de controle é igual ao resto da divisão dessa soma por 7.

Exemplos:

Entrada 1:
123
Saída Esperada 1:
1231

Entrada 2:
555
Saída Esperada 2:
5553

Entrada 3:
841
Saída Esperada 3:
8414
}


program Costruction;

var num, conta, trasforma, primeiro, segundo, terceiro:longint;

begin
    read(num);
    primeiro:=(num div 100);
    segundo:=((num mod 100)div 10)*3;
    terceiro:=((num mod 100)mod 10)*5;
    conta:=primeiro+segundo+terceiro;
    trasforma:= conta mod 7;
    writeln(num,trasforma);
end.