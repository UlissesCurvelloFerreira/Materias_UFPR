{
Enunciado:
Observe a soma infinita abaixo. Ela é formada por frações em que cada numerador é o dobro do denominador da fração anterior e cada denominador, por sua vez, é o dobro do numerador da fração anterior (exceto a primeira fração).

Imgur

Faça um programa em Pascal para calcular o valor real de S, considerando apenas os 10 primeiros termos da série. Ao final, imprimir o resultado encontrado para S com duas casas decimais.
}


program ex002;

var cont, num, den, aux, soma:real;

begin
    cont:= 0;
    num:=1;
    den:=3;
    
    while cont < 10 do
    begin
        soma:= soma+ num/den;   (*pega o divisão da fração*)
        aux:= num;
        num:= den * 2;      (*multiplica o denominador por 2*)
        den:= aux *2;        (*multiplica o numerador qu está no aux por 2*)
        cont:= cont+1
    end;
    write(soma:0:2);

end.