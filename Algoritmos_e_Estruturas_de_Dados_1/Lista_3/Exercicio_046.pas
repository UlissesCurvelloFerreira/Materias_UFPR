{
Enunciado:
Faça um programa Pascal que leia do teclado um conjunto de números onde cada linha contém dois valores numéricos sendo o primeiro do tipo real e o segundo do tipo inteiro. O segundo valor é o peso atribuído ao primeiro valor. O programa deve calcular e imprimir com duas casas decimais a média ponderada dos diversos valores lidos. A última linha de dados contém dois números zero. Esta linha não deve ser considerada no cálculo da média e serve apenas para marcar o final da entrada de dados.

Isto é, calcular o seguinte, supondo que m linhas foram digitadas:

N1 × P1 + N2 × P2 + ... + Nm × Pm
--------------------------------
      P1 + P2 + ... + Pm

Imprima o resultado com duas casas decimais.

Exemplos:

Entrada 1:
60 1
30 2
40 3
0 0

Saida esperada 1:
40.00
}


program ex048;

var n1 :longint;
    n2, conta, peso, calculo: real;

begin
    read(n1, n2);
    
    while (n1 <> 0) and (n2 <> 0) do
    begin
        conta:= conta+(n1*n2);
        peso:=peso+n2;
        calculo:=(conta/peso);
        read(n1, n2);
        
    end;
    write(calculo:0:2);
end.