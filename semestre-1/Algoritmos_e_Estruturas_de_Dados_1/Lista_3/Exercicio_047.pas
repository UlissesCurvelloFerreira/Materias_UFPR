{
Enunciado:
Faça um programa Pascal que calcule o valor da soma dos quadrados dos primeiros 50 inteiros positivos não nulos e imprima o resultado do cálculo na tela. Observe que este programa não tem entrada, apenas saída.

Soma = Σ i=1^50 i^2 = 1^2 + 2^2 + 3^2 + ... + 50^2
}


program quadradoNum;

var n, acumula, i:longint;

begin
    n:=50;
    acumula:=0;
    i:=50;
    while i <> 0 do
        begin
            acumula:=acumula+(n*n);
            n:= n-1;
            i:=i-1;
        end;
    write(acumula);
end.