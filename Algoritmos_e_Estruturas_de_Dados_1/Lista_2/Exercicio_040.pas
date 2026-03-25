{
Enunciado:
Faça um programa Pascal que leia uma sequência de números inteiros terminada em zero e imprima o maior e o menor número dessa sequência. O valor zero não deve ser processado, ele serve para marcar o final da entrada de dados.

Exemplos:

Entrada 1:
1 55 30 -2 560 -1 0
Saída Esperada 1:
560 -2

Entrada 2:
-3 -4 -30 -10 0
Saída Esperada 2:
-3 -30
}


program maiorQue;
var num, maior, menor :longint;
begin
     read(num);
     maior:=0;
     menor:=0;
     while num <> 0 do
        begin
            if (num > maior) or (maior = 0) then
                maior:= num;
            if (num < menor) or (menor = 0)then
                menor:= num;
        read(num);
        end;
        write(maior, ' ', menor);
end.