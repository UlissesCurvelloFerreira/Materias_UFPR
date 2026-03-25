{
Enunciado:
Faça um programa Pascal que leia do teclado um valor inteiro que é a área de um cômodo e imprima um valor inteiro que é a potência de iluminação necessária para iluminá-lo de acordo com a seguinte relação:

- 100 watts para cômodos com 6 m² ou menos;
- 80 watts para os primeiros 3 m² e mais 15 watts a cada 1 m² de acréscimo para cômodos maiores que 6 m².

Exemplos:

Entrada 1:
5
Saída Esperada 1:
100

Entrada 2:
9
Saída Esperada 2:
170
}


program iluminacao;

var num, conta : longint;

begin
    read(num);
    conta:=(num-3)*15;
    
    if num <= 6 then
        write(100)
    else
        write(80+conta);
end.