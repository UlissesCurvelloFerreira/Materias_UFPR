{
Enunciado:
Faça um programa Pascal que leia um número inteiro e imprima o seu sucessor e seu antecessor, na mesma linha.

Exemplos:

Entrada 1:
1
Saída Esperada 1:
2 0

Entrada 2:
100
Saída Esperada 2:
101 99
}


program sucessorAntecessor;

var 
    num, sucessor, antecessor: longint;

begin
    read(num);
    sucessor:= num+1;
    antecessor:= num-1;
    write(sucessor, ' ', antecessor);
end.
