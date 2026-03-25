{
Enunciado:
Faça um programa Pascal que leia do teclado uma quantidade arbitrária de números inteiros positivos terminada em zero e identifique o maior múltiplo de 7 (sete) entre esses números. Depois da leitura dos dados, o maior múltiplo de 7 encontrado deve ser impresso. O número zero serve para indicar o final da entrada e não deverá ser processado. Caso não haja nenhum múltiplo de sete na entrada o programa deve imprimir a mensagem NENHUM.

Exemplos:

Entrada 1:
4 8 3 63 99 41 28 99 65 0

Saída Esperada 1:
63

Entrada 2:
739 805 568 382 490 51 719 403 240 152 0

Saída Esperada 2:
805
}


program ex057;

var n, maior: longint;

begin
    read(n);
    maior:=0;
    
    while n <> 0 do
    begin
    
        if (n mod 7 = 0) and (n>maior)then
            maior:=n;
            
    read(n);
    end;
    write(maior);

end.

