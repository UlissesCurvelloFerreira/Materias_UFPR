{
Enunciado:
Um inteiro positivo N é considerado perfeito se o mesmo for igual a soma de seus divisores positivos diferentes de N.

Exemplo: 6 é perfeito pois 1 + 2 + 3 = 6 e 1, 2 e 3 são todos os divisores positivos de 6 e que são diferentes de 6.

Faça um programa Pascal que leia um número inteiro positivo K e mostre os K primeiros números que são perfeitos.

Exemplos:

Entrada 1:
1
Saída Esperada 1:
6

Entrada 2:
2
Saída Esperada 2:
6 28
}



program verificanum;

var parametro, verifica, soma, num: integer;

begin
    read(num);
    parametro:=6;
    while (num > 0) do
    begin
        soma := 0;
        verifica := 1;
        while (verifica<=(parametro/2))do
            begin
                if (parametro mod verifica)=0 then
                        soma:=soma+verifica;
                verifica:=verifica+1;
            end;
        if (soma = parametro) then 
            begin
                write(parametro,' ');
                num:=num-1;
            end;
        parametro:=parametro + 1;
    end;
end.