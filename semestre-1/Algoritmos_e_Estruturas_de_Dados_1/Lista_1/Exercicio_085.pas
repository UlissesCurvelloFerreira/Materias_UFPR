{
Faça um programa Pascal que leia um número real representando o diâmetro (em metros) de uma esfera.
Calcule e imprima o volume desta esfera com duas casas decimais.
O volume de uma esfera é dado por:
V = (4 * pi / 3) * R^3, onde pi = 3.14 e R = diâmetro / 2

Exemplos:
Entrada 1:
3
Saída Esperada 1:
14.13

Entrada 2:
10
Saída Esperada 2:
523.33
}


program ex_um;
var diametro, raio, volume: real;
begin
    read(diametro);
    raio:= diametro/2;
    volume:=((4*3.14)/3)*(raio*raio*raio);
    writeln(volume:0:2);
end.