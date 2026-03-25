{
Enunciado:
Faça um programa Pascal que leia do teclado dois valores reais x e y, e em seguida calcule e imprima o valor da seguinte expressão com três casas decimais:
+√y / x  (interpretação da expressão indicada)

Exemplos:

Entrada 1:
43
Saída Esperada 1: 2.083

Entrada 2:
85
Saída Esperada 2: 2.225
}


program CalculaExpressao;
uses
  SysUtils;

var
  x, y: Real;
  resultado: Real;

begin
  ReadLn(x, y);
  resultado := (x / y) + (y / x);
  WriteLn(FormatFloat('0.000', resultado));
end.
