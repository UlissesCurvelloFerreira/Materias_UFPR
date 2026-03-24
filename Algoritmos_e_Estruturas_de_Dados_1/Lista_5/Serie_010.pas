{
Enunciado:
Faça um programa em Pascal que leia do teclado um número inteiro n > 0 outro número real x e em seguida calcule e imprima o resultado de S calculado com n termos, com duas casas decimais, conforme definido abaixo:
S = (x ^ 0)/(1!) + (x ^ 4)/(2!) - (x ^ 8)/(3!) + (x ^ 12)/(1!) + (x ^ 16)/(2!) - (x ^ 20)/(3!)
}


program Serie;

var
  n, i: integer;
  x, S, potencia, fat: real;
  sinal: integer;

begin
  read(n);
  read(x);

  S        := 0.0;
  potencia := 1.0;

  for i := 1 to n do
  begin
    { x^(4*(i-1)) acumulado }
    if i > 1 then
      potencia := potencia * x * x * x * x;

    { Fatorial ciclico: 1!, 2!, 3! }
    case (i - 1) mod 3 of
      0: fat := 1.0;
      1: fat := 2.0;
      2: fat := 6.0;
    end;

    { Sinal ciclico: +, +, - }
    case (i - 1) mod 3 of
      0: sinal :=  1;
      1: sinal :=  1;
      2: sinal := -1;
    end;

    S := S + sinal * (potencia / fat);
  end;

  writeln(S:0:2);
end.