{
Enunciado:
Dadas as populações Pa e Pb de duas cidades A e B (no ano atual) e suas respectivas taxas de crescimento anual Ta e Tb, faça um programa Pascal que que receba 4 números reais como entrada (Pa, Pb, Ta, Tb) representando estas informações e determine se a população da cidade de menor população ultrapassará a de maior população e se sim, imprima em quantos anos que isto ocorrerá. Caso contrário, imprima 0.

Observe que O enunciado indica a existência de 4 casos possíveis: (1) a população A é menor do que a de B com taxa de crescimento de A menor do que a de B; (2) a população de A é menor do que a de B com taxa de crescimento maior do que a de B. As situações (3) e (4) são análogas e consideram que a população de B é menor do que a de A.

Dica: Como na saída só importa o número de anos em que supostamente uma população ultrapassará a outra, não importando qual dentre elas, você pode reduzir o problema a apenas dois casos usando um artifício do programador, ele pode testar as populações e taxas e fazer uso de variáveis auxiliares (ou então de trocas) para promover esta redução. Com isso pode-se usar apenas um laço.

Exemplos:

Entrada 1:
300 500 0.12 0.05
Saída Esperada 1:
8

Entrada 2:
300 500 0.1 0.5
Saída Esperada 2:
0
}


program ex009;
var
    pa, pb, ta, tb, a: real;

begin
    a := 0;
    read(pa, pb, ta, tb);
    if (pa > pb) and (tb > ta) then
    begin
        ta := 1 + ta;
        tb := 1 + tb;
        while (pa > pb) do
        begin
            pa := pa * ta;
            pb := pb * tb;
            a := a + 1;
        end;
        writeln(a:0:0);
    end;
    if (pb > pa) and (ta > tb) then
    begin
        ta := 1 + ta;
        tb := 1 + tb;
        while (pb > pa) do
        begin
            pa := pa * ta;
            pb := pb * tb;
            a := a + 1;
        end;
        writeln(a:0:0);
    end;
    if (a = 0) then writeln('0');
end.