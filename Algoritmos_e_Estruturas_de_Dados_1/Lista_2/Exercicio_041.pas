{
Enunciado:
Faça um programa Pascal que receba um número positivo N e imprima na tela a soma dos N primeiros números da sequência de Fibonacci. Os dois primeiros números da sequência são 0 e 1, e os próximos são dados pela soma dos dois últimos números anteriormente calculados.

A título de exemplo, os oito primeiros valores dessa sequência são: 0, 1, 1, 2, 3, 5, 8, 13.

Exemplos:

Entrada 1:
3
Saída Esperada 1:
2

Entrada 2:
5
Saída Esperada 2:
7
}


program fibonacci;


var num, s1, s2, acumulador, somador:longint;

begin
    read(num);
    s1:=0;
    s2:=1;
    somador:=0;
    acumulador:=0;
    
    while acumulador <> num do
        begin
            acumulador:=acumulador+1;
            somador:=(s1+s2);
            s1:=s2;
            s2:=somador;
        end;
        
    writeln(somador-1);
end.