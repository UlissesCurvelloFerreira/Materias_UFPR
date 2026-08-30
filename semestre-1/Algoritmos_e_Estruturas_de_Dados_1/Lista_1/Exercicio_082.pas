{
Enunciado:
Dado um número inteiro que representa uma quantidade de segundos, faça um programa que imprima o seu valor equivalente em horas, minutos e segundos, nesta ordem. 
Se a quantidade de segundos for insuficiente para dar um valor em horas, o valor em horas deve ser 0 (zero). A mesma observação vale em relação aos minutos e segundos.

Exemplos:

Entrada 1:
3600
Saída Esperada 1:
1:0:0

Entrada 2:
3500
Saída Esperada 2:
0:58:20

Entrada 3:
7220
Saída Esperada 3:
2:0:20
}


program converte;

var hora, minuto, segundo: longint;

begin
    read(segundo);
    (*converte as horas*)
    hora:= segundo div 3600;
     (*converte as minutos*)
    minuto:= (segundo-(hora*3600))div 60;
     (*converte as segundos*)
    segundo:= segundo - (hora*3600)-(minuto*60);
    
    write(hora,':',minuto,':',segundo);
end.