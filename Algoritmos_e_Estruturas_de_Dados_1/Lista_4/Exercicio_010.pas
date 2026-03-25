{
Enunciado:
Um número inteiro positivo é dito triangular se seu valor é o produto de três números naturais consecutivos. Por exemplo, o número 120 é triangular porque 120 = 4 x 5 x 6.

Faça um programa Pascal que leia do teclado um número inteiro positivo n e verifique se ele é triangular ou não. Se for, imprima 1 e se não for, imprima 0.

Exemplos:

Entrada 1:
120
Saída Esperada 1:
1

Entrada 2:
123
Saída Esperada 2:
0

Entrada 3:
6
Saída Esperada 3:
1
}


program e;

var n,i:integer;
    b:boolean;
    
begin
    read(n);
    b:=false;
    i:=1;
    while (i<=n) and (b=false) do
    begin
        if (i*(i+1)*(i+2))=n then
            b:=true
        else
            i+=1;
    end;
    if b=true then 
        writeln('1')
    else
        writeln('0');
end.