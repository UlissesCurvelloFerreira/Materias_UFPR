{
Enunciado:
Faça um programa Pascal que leia do teclado um conjunto de 4 valores i, a, b, c, sendo que i é um valor inteiro e positivo e a, b, c, são quaisquer valores reais. Imprima na tela os valores de a, b, c da seguinte forma:

- os três valores a, b, c em ordem crescente, se i = 1;
- os três valores a, b, c em ordem decrescente, se i = 2;
- os três valores a, b, c de forma que o maior dentre a, b, c fique entre os outros dois valores, com a ordem relativa entre os outros dois mantida, se i = 3. Observe no exemplo de teste 2 que o maior valor (68) foi impresso na saída esperada no meio, e os valores 5 e 45 ficaram na mesma ordem relativa, isto é, o 5 aparece antes do 45 na saída porque na entrada eles estavam nesta ordem.

Exemplos:

Exemplo 1:
1 34 12 21
Saída Esperada 1:
12 21 34

Exemplo 2:
3 68 5 45
Saída Esperada 2:
5 68 45
}


program ex029;

var 
    a, b, c, a0, b0, c0, recebe:real;
    i: longint;

begin
    read(i, a, b, c);
    
    a0 := a;
    b0 := b;
    c0 := c;

    if a > c then
    begin
        recebe:= a;
        a:= c;
        c:= recebe;
    end;
    if a > b then
    begin
        recebe:= a;
        a:= b;
        b:= recebe;
    end;
    if b > c then
    begin
        recebe:= b;
        b:= c;
        c:= recebe;
    end;
    if i = 1 then
        writeln(a:0:0, ' ', b:0:0, ' ', c:0:0)
    else if i = 2 then
        writeln(c:0:0, ' ', b:0:0, ' ', a:0:0)
    
        
    else if i = 3 then
    begin
        if c = a0 then
        writeln(b0:0:0, ' ', a0:0:0, ' ',c0:0:0)
        else if c = b0 then
        writeln(a0:0:0, ' ', b0:0:0, ' ',c0:0:0)
        else if c = c0 then
        writeln(a0:0:0, ' ', c0:0:0, ' ',b0:0:0)
    end;
    

end.