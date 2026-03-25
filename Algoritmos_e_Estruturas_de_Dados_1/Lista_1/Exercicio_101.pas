{
Enunciado:
Faça um programa Pascal que, usando apenas atribuições e expressões aritméticas, imprima ao contrário um número inteiro de três dígitos lido pelo teclado. Desconsidere números que começam ou terminam em zero.

Exemplos:

Entrada 1:
123
Saída Esperada 1:
321

Entrada 2:
891
Saída Esperada 2:
198

Entrada 3:
565
Saída Esperada 3:
565
}


program inverte;

var num, inicio, meio, fim: longint;

begin

    read(num);
    
    inicio:= num div 100;
    meio:= (num mod 100) div 10;
    fim:=(num mod 100) mod 10;
    writeln (fim,meio,inicio);
  
end.

