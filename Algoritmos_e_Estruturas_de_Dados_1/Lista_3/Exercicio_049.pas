{
Enunciado:
Uma agência governamental deseja conhecer a distribuição da população do país por faixa salarial. Para isto, coletou dados do último censo realizado e criou um arquivo contendo, em cada linha, o salário de um cidadão particular. Os salários variam de zero a 19.000,00 unidades da moeda local.

Considere o salário mínimo igual a 450,00 unidades da moeda local.

As faixas salariais de interesse são as seguintes:

de 0 a 3 salários mínimos
de 4 a 9 salários mínimos
de 10 a 20 salários mínimos
acima de 20 salários mínimos.

Faça um programa Pascal que leia uma sequência de números reais, que será terminada em zero. O zero não deve ser processado e serve para terminar o programa. O programa deve imprimir na tela os percentuais da população para cada faixa salarial de interesse.

Exemplos:

Entrada 1:
240.99
2720.77
4560.88
19843.33
834.15
315.87
5645.80
150.33
2560.00
2490.05
0.00

Saída Esperada 1:
40.00
30.00
20.00
10.00
}


program mediasalarialdopais;

var salario, faixa1, faixa2, faixa3,faixa4: real;
var cont: longint;

begin
read(salario);
cont:= 0;
faixa1:=0;
faixa2:=0;
faixa3:=0;
faixa4:=0;
  while salario<>0 do
    begin
      if (salario>0) and (salario <= 1799) then
          faixa1:= faixa1+1
      else if (salario>= 1800) and (salario<=4499) then
          faixa2:=faixa2+1
      else if (salario>=4500) and (salario<=8999) then
          faixa3:= faixa3+1
      else if salario>=9000 then
          faixa4:= faixa4+1;
    cont:= cont+1;
    read(salario);
    end;
writeln ((faixa1*100)/cont:0:2);
writeln ((faixa2*100)/cont:0:2);
writeln ((faixa3*100)/cont:0:2);
writeln ((faixa4*100)/cont:0:2);
end.