
{
Enunciado:
Faça um programa em Pascal que leia do teclado um número inteiro positivo N. Depois disso, o programa deve calcular e imprimir a soma de todas
as frações em que a soma do numerador com o denominador de cada fração seja o número N.

Por exemplo, se N=7, o programa deve calcular a soma abaixo:

Imgur

Seu programa deve imprimir a saída o valor real com duas casas decimais.

Exemplo:
Entrada 1:
7
Saída Esperada 1:
11.15

Entrada 2:
4
Saída Esperada 2:
4.33
}


program fracao;

var n:longint;
    nume, deno, conta:real;

begin
    read(n);
    nume:=0;
    deno:=n;
    
    while n <> 0 do
    begin
        conta:=conta+(nume/deno);
        nume:=nume+1;
        deno:=deno-1;
        n:=n-1;
    end;
    writeln(conta:0:2);
end.