{
Enunciado:
Faça um programa Pascal que leia do teclado dois valores inteiros que são as coordenadas (X,Y) de um ponto no sistema cartesiano. Imprima na tela o quadrante ao qual o ponto pertence: 1, 2, 3 ou 4, conforme as regras clássicas da matemática.

Caso o ponto não pertença a nenhum quadrante, imprima a letra X se ele está sobre o eixo X; imprima a letra Y se ele está sobre o eixo Y; ou então imprima a letra O, caso ele esteja na origem.

Exemplos:

Exemplo de entrada 1:
4 4
Saída Esperada 1:
1

Exemplo de entrada 2:
4 0
Saída Esperada 2:
X
}


program planoCartesiano;

var p1, p2: longint;

begin
    read(p1, p2);
    if (p1 > 0) and (p2 > 0) then
        write(1)
    else if (p1 < 0) and (p2 > 0) then
        write(2)
    else if (p1 < 0) and (p2 < 0) then
        write(3)
    else if (p1 > 0) and (p2 < 0) then
        write(4)
    else if (p1 = 0) and (p2 = 0) then
        write('O')
    else if p1 = 0 then
        write('Y')
    else if p2 = 0 then
        write('X');
end.