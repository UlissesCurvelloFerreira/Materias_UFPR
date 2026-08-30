
{
Enunciado:
Faça um programa em Pascal que leia um inteiro positivo n, e escreva a soma real dos n primeiros termos da série abaixo:

Imgur

Imprima a saída com duas casas decimais.

Dica: o operador unário - pode ser usado para controlar o sinal.

Exemplo:
Entrada 1:
2
Saída Esperada 1:
501.50

Entrada 2:
4
Saída Esperada 2:
585.08
}


program fracaoTRes;

var nume, deno, num :longint;
    conta:real;

begin
    read(num);
    nume:=1000;
    deno:=1;
    conta:=0;
    while num <> 0 do
    begin
        if (num mod 2 = 0) or (deno = 1) then
            conta:= conta+(nume/deno)
        else
            conta:=conta-(nume/deno);
        nume:=nume-3;
        deno:=deno+1;
        num:=num-1;
    end;
    writeln(conta:0:2);
end.