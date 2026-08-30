{
Faça um programa Pascal que leia um número inteiro, calcule se ele é divisível por 3 e por 7. 
Caso seja, imprima SIM e caso não seja imprima NAO. Dica: use o operador AND.

Exemplos:
Entrada 1:
21
Saída Esperada 1:
SIM

Entrada 2:
7
Saída Esperada 2:
NAO

Entrada 3:
-3
Saída Esperada 3:
NAO
}


program porTresSete;

var n: longint;

begin
    read(n);

    if ((n mod 3) = 0) and ((n mod 7) = 0) then
        write('SIM')
    else
        write('NAO');
end.