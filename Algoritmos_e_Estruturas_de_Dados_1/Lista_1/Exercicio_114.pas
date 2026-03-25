{
Faça um programa Pascal que leia um número inteiro do teclado, calcule se ele é ou não divisível por 5. Imprima SIM caso ele seja e NAO em caso contrário.

Exemplos:
Entrada 1:
5
Saída Esperada 1:
SIM

Entrada 2:
-5
Saída Esperada 2:
SIM

Entrada 3:
3
Saída Esperada 3:
NAO
}


program porCinco;

var n: longint;

begin
    read(n);
    if (n mod 5) = 0 then
        write('SIM')
    else
        write('NAO');
end.