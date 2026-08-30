{
Enunciado:
Observe a soma infinita abaixo. Ela é formada por frações em que o numerador e o denominador são os valores sucessores dos valores do
numerador e do denominador da frações anterior, porém, alternadamente invertidos (exceto a primeira fração).

Imgur

Faça um programa em Pascal para calcular o valor real de S, considerando apenas os 10 primeiros termos da série. Ao final, imprimir o resultado encontrado para S com 2 casas decimais.
}


program fracaoCinco;

var nume, deno, conta:real;
    i:longint;

begin
    conta:=0;
    nume:=1;
    deno:=2;
    i:=10;
    
    while i <> 0 do
        begin
            conta:=conta+(nume/deno);
            if i mod 2 = 1 then
                begin
                    nume:=nume+1;
                    deno:=nume+1;
                end
            else
                begin
                    deno:=deno+1;
                    nume:=deno+1
                end;
            i:=i-1;
        end;
    
    writeln(conta:0:2);
end.