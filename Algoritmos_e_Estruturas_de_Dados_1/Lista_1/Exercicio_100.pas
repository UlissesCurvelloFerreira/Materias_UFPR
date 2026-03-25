{
Enunciado:
Observemos o número 3025. Ele possui a seguinte característica:

Faça um programa Pascal que leia um número inteiro do teclado. Considere que o usuário sempre digita números com 4 dígitos sem zeros no início ou final. Imprima na tela uma mensagem indicando se o número tem a propriedade citada acima. Dica: use o operador AND.

Exemplos:

Entrada 1:
3025
Saída Esperada 1:
SIM

Entrada 2:
123
Saída Esperada 2:
NAO
}


program propriedade;

var num, inicio, fim, aux: longint;

begin

    read(num);
    
    inicio:= (num div 100) ;
    fim:= (num mod 100);
    
    aux:= inicio + fim;
    
    if (aux*aux) = num then
        write('SIM')
    else
        write('NAO');

end.

