{
Enunciado:
Faça um programa Pascal que leia do teclado um número inteiro m e em seguida uma sequência de outros m números reais. Imprima a média aritmética REAL entre eles. Imprima com duas casas decimais.

N₁ + N₂ + ... + Nₘ
-----------------
        m

Exemplos:

Entrada 1:
2 2 4
Saida Esperada 1:
3.00

Entrada 2:
5 8 9 6 5 7
Saida Esperada 2:
7.00
}


program ex052;

var m, i: longint;
var n, soma : real;

begin
read (m);
soma := 0;
  
  while i<>m do
  begin
    i:= i+1;
    read (n);
    soma:= soma+n;
  end;
writeln (trunc(soma/m));
end.