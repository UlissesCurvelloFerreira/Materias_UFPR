{
Faça um programa Pascal que leia do teclado um número inteiro e imprima SIM caso o número seja ímpar, negativo e menor que -20,
ou então se for par, positivo e maior que 7. Caso contrário, imprima NAO.
Dica: usar operadores AND e OR.

Observação: o operador MOD quando aplicado a números negativos resulta em valor negativo.
Exemplo: -101 mod 2 resulta em -1.

Exemplos:
Entrada 1:
17
Saída Esperada 1:
NAO

Entrada 2:
-101
Saída Esperada 2:
SIM

Entrada 3:
-13
Saída Esperada 3:
NAO
}


program VerificaNumero;
var
  n: integer;
begin
  readln(n);
  if ((n mod 2 <> 0) and (n < 0) and (n < -20)) or ((n mod 2 = 0) and (n > 0) and (n > 7)) then
    writeln('SIM')
  else
    writeln('NAO');
end.
