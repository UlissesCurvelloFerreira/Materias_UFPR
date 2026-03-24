{
Enunciado:
Observe a soma infinita abaixo. Ela é formada por frações em que cada numerador é a soma entre o numerador e o denominador da fração anterior e cada denominador, por sua vez, é a soma do seu numerador com o denominador da fração anterior (exceto a primeira fração).

Imgur

Faça um programa em Pascal que calcula o valor de S, considerando apenas os 5 primeiros termos da série. Ao final, imprimir o resultado real encontrado para S com duas casas decimais.
}




program ex002;

var numerador, denominador, soma, contador: real;

begin
    contador:=1;
    numerador:= 1;
    denominador:= 1;
    soma:= 0;
    
    while contador <= 5 do
    begin
        soma:=soma+numerador/denominador;
        numerador:= numerador+denominador;
        denominador:= numerador+denominador;
        contador:=contador+1;
    end;
    write(soma:0:2);
end.