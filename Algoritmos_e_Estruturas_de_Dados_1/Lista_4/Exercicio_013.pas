{
Enunciado:
Faça um programa Pascal que leia do teclado três números inteiros positivos: i, j e k. Se j for múltiplo de i e k for múltiplo de j, o programa deve imprimir a soma dos três. Se os três valores forem consecutivos na ordem lida, o programa deve imprimi-los na ordem decrescente.
Em qualquer outra situação, o programa deve calcular e imprimir a média aritmética inteira dos três valores. Use operadores inteiros.

Exemplos:

Entrada 1:
33 165 495
Saída Esperada 1:
693

Entrada 2:
74 75 76
Saída Esperada 2:
76 75 74

Entrada 3:
7 20 12
Saída Esperada 3:
13
}


program ex013;
var
    i, j, k: integer;

begin

    read(i, j, k);
    
    if((j mod i) = 0) and ((k mod j) = 0) then 
    writeln(i + j + k)
    
    else if(i = j - 1) and (i = k - 2) then 
    writeln(k, ' ', j, ' ', i)
    
    else 
    writeln(((i + k + j) / 3):0:0);
    
end.