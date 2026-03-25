{
Enunciado:
Sabe-se que para iluminar de maneira correta os cômodos de uma casa, para cada Metro quadrado (m²) deve-se usar 18W de potência.
Faça um programa Pascal que:

- receba dois inteiros representando as duas dimensões de um cômodo em metros;
- calcule e imprima a sua área em m²;
- imprima a potência de iluminação que deverá ser usada em watts.

Exemplos:

Entrada 1:
10 10
Saída Esperada 1:
100 1800

Entrada 2:
5 7
Saída Esperada 2:
35 630
}



program iluminacao;

var 
    n1, n2, area, luz: longint;

begin
    read(n1, n2);
    area:= n1*n2;
    luz:= area*18;

    write(area,' ',luz);
end.