{
Faça um programa Pascal que leia um número inteiro do teclado e imprima SIM se ele está compreendido entre 20 e 90 ou NAO caso contrário.
Observação: 20 e 90 não estão na faixa de valores.

Exemplos:
Entrada 1:
50
Saída Esperada 1:
SIM

Entrada 2:
20
Saída Esperada 2:
NAO

Entrada 3:
90
Saída Esperada 3:
NAO
}


program entre;

var n: longint;

begin
    read(n);
    if (n > 20) and (n < 90) then
        write('SIM')
    else
        write('NAO');
end.