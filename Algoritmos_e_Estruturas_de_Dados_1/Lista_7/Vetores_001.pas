{
  Faça um programa em Free Pascal que:
  1. Leia um número inteiro n (0 ≤ n ≤ 200).
  2. Leia uma sequência de n valores reais e armazene-os em um vetor.
  3. Calcule:
     - A soma dos valores positivos que estão em posições pares do vetor.
     - A soma dos valores negativos que estão em posições ímpares do vetor.
  4. Imprima o resultado da divisão da soma dos positivos em posições pares
     pela soma dos negativos em posições ímpares.
  5. Trate casos especiais:
     - Se o vetor estiver vazio (n = 0), imprimir "vetor vazio".
     - Se a soma dos negativos em posições ímpares for zero, imprimir "divisao por zero".
  6. Caso contrário, imprimir o resultado da divisão com duas casas decimais.

  Exemplo de entrada 1:
  4
  -2.0 -7.0 7.0 2.0
  Saída esperada 1:
  -1.00

  Exemplo de entrada 2:
  3
  1 2 3
  Saída esperada 2:
  divisao por zero

  Exemplo de entrada 3:
  0
  Saída esperada 3:
  vetor vazio
}


program ex001;
type vetor = array[1..200] of real; 
var
    n: integer;
    somaP, somaI: real;
    vetNumeros: vetor;


procedure leiaNumeros(var v: vetor; var tam: integer);
var i: integer;
begin
    read(tam);
    for i := 1 to tam do
    begin
        read(v[i]);
    end;
end;


function somaPosicaoPares(v: vetor; tam: integer):real;
var i: integer;
begin
    somaPosicaoPares := 0;
    for i:=1 to tam do
    begin
        if ((i mod 2 = 0) and (v[i] > 0)) then somaPosicaoPares := somaPosicaoPares + v[i];
    end;
end;


function somaPosicaoImpares(v: vetor; tam: integer):real;
var i: integer;
begin
    somaPosicaoImpares := 0;
    for i:=1 to tam do
    begin
        if ((i mod 2 = 1) and (v[i] < 0)) then somaPosicaoImpares := somaPosicaoImpares + v[i];
    end;
end;


begin
    leiaNumeros(vetNumeros, n);
    somaP := somaPosicaoPares(vetNumeros, n);
    somaI := somaPosicaoImpares(vetNumeros, n);
    if somaI <> 0 then writeln((somaP / somaI):0:2)
    else if (somaI = 0) and (somaP <> 0) then writeln('divisao por zero')
    else writeln('vetor vazio');
end.