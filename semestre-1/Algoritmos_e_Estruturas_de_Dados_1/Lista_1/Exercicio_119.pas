{
Enunciado:
Considere a razão r de uma P.A. (Progressão Aritmética) e um termo qualquer, k (ak). Escreva um programa Pascal para calcular o enésimo termo n (an). Seu programa deve ler quatro valores inteiros k, ak, r, n do teclado e imprimir o inteiro an, segundo a fórmula:

an = ak + (n - k) * r

Exemplos:

Entrada 1:
1 5 2 10
Saída Esperada 1:
23

Entrada 2:
10 20 2 5
Saída Esperada 2:
10

Entrada 3:
100 500 20 90
Saída Esperada 3:
300
}


program  enesimoTermo;
var
    k, ak, r, n, conta: longint;

begin
    read( k, ak, r, n);
    
    conta:= ak + ((n-k)*r);
    write(conta);
end.