{
Enunciado:
Faça um programa Pascal que leia uma sequência de números reais terminada em 0 que representam a medida dos lados de um polígono e imprima "SIM" se ele é um polígono regular (todos os seus lados iguais) e "NAO" caso contrário.
Note que um polígono precisa ter ao menos 3 lados para ser um polígono. O número zero serve para indicar o final da entrada de dados e não deve ser processado.

Exemplos:

Entrada 1:
1 2 3 0
Saída Esperada 1:
NAO

Entrada 2:
4 4 4 4 0
Saída Esperada 2:
SIM

Entrada 3:
4 4 0
Saída Esperada 3:
NAO
}


program poligonos;

var lado, val, num, contaLados:real;

begin
    read(lado);
    contaLados:=0;
    val:=1;
    
    while lado <> 0 do
    begin
        if (num = 0) then
            num:= lado
        else if (lado <> num) then
            val:=0;
            
    contaLados:= contaLados+1;
    read(lado);
    end;

    if (val=0) or (contaLados < 3) then
        writeln('NAO')
    else
        writeln('SIM');
end.
    
    