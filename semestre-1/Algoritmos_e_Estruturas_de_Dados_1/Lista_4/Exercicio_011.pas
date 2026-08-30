{
Enunciado:
Faça um programa Pascal que leia do teclado um número inteiro maior do que 1. Seu programa deve imprimir SIM caso ele seja primo e NAO caso contrário.

Dica: o único número par que é primo é o 2.

Exemplos:

Entrada 1:
13
Saída Esperada 1:
SIM

Entrada 2:
7
Saída Esperada 2:
SIM

Entrada 3:
26
Saída Esperada 3:
NAO
}


program ex011;
var
    num, divs, qt_divs: longint;

begin
    qt_divs := 0;
    divs := 1;
    read(num);
    while(divs <= num) do
    begin
        if (num mod divs) = 0 then qt_divs := qt_divs + 1;
        divs := divs + 1;
    end;
    if (qt_divs = 2) then writeln('SIM')
    else writeln('NAO');
end.