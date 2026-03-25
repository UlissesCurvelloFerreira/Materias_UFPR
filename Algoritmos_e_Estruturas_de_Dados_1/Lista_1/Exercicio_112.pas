{
Faça um programa Pascal que leia do teclado um número inteiro N e imprima se ele é PAR ou IMPAR.

Exemplos:
Entrada 1:
5
Saída Esperada 1:
IMPAR

Entrada 2:
3
Saída Esperada 2:
IMPAR

Entrada 3:
2
Saída Esperada 3:
PAR
}


program parImpar;

var n: longint;

begin
    read(n);
    if (n mod 2) = 0 then
        write('PAR')
    else
        write('IMPAR');
end.