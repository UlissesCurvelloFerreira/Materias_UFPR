{
Enunciado:
Faça um programa Pascal que leia um número inteiro positivo N do teclado. Depois disso, o programa deve calcular e imprimir todos os arranjos de dois números inteiros positivos A, B, ambos menores que N, de forma que quando somados (A + B), resultam no número N. Cada arranjo A, B deve ser impresso em uma linha de saída.

Exemplos:

Entrada 1:
7

Saída Esperada 1:
1 6
2 5
3 4
4 3
5 2
6 1
}


program arranjos;

var N,A,B:longint;
begin
    read(N);
    
    A:=N;
    B:=0;
    
    while (N-1) > 0 do
        begin
            A:=A-1;
            B:=B+1;
            N:=N-1;
            writeln(B,' ',A);
        end;
end.