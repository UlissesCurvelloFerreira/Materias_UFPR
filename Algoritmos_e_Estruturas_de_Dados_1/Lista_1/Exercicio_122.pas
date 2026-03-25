{
Enunciado:
Uma P.A. (Progressão Aritmética) é determinada pela sua razão r e pelo primeiro termo (a1). Faça um programa Pascal que seja capaz de imprimir o enésimo (n) termo (an) de uma P.A., dado a razão (r) e o primeiro termo (a1). Seu programa deve ler três valores inteiros do teclado (n, r, a1) e imprimir o inteiro an, segundo a fórmula:

an = a1 + (n-1) * r

Exemplos:

Entrada 1:
8 1 3
Saída Esperada 1:
10

Entrada 2:
100 10 1
Saída Esperada 2:
991

Entrada 3:
5 -2 0
Saída Esperada 3:
-8
}


program pa;

var n, r, a1, conta: longint;

begin
    read(n, r, a1);
    conta:= a1+(n-1)*r;
    write(conta);

end.