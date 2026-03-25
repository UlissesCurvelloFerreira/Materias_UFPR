{
Enunciado:
Alguém deseja cobrir as paredes de uma cozinha com azulejos. As lojas somente vendem caixas com 10 azulejos. Todas as lojas do ramo vendem apenas 3 (três) tipos de azulejos, cujas dimensões são:

- 50cm x 40cm;
- 50cm x 60cm;
- 50cm x 80cm.

Faça um programa Pascal que leia do teclado dois valores inteiros representando respectivamente o tipo do azulejo desejado (um dos números 1, 2 ou 3) e a área que se deseja azulejar, em metros quadrados. Seu programa deve imprimir a quantidade de caixas de azulejos que deverão ser compradas para cobrir toda a área. Considere que pedaços de azulejo podem ser reaproveitados, de maneira a minimizar a quantidade de caixas.

Exemplos:

Entrada 1:
2 122
Saída Esperada 1:
41 caixas
}


program ex036;

var tipo, area, conta, conta1, conta2: double;

begin 
    read(tipo, area);
    if tipo = 1 then
    begin
        conta:= (area*10000)/((50*40)*10);
        writeln(round(conta), ' caixas');
    end
    else if tipo = 2 then
    begin
        conta1:= (area*10000)/((50*60)*10);
        writeln(round(conta1), ' caixas');
    end
    else if tipo = 3 then
    begin
        conta2:= ((area*10000)/((50*80)*10)+0.2);
        writeln(round(conta2), ' caixas');    
    end
end.