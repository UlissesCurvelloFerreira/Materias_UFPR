{
Enunciado:
Faça um programa Pascal que leia um número d que é um dígito entre 0 e 9 e depois leia um outro inteiro n qualquer. Em seguida conte quantos dígitos d existem em n. Se não existir nenhum dígito correspondente, a mensagem "NAO" deve ser impressa. Caso contrário imprima o resultado do seu cálculo.

Exemplos:

Entrada 1:
9
95949
Saída Esperada 1:
3

Entrada 2:
1
2353
Saída Esperada 2:
NAO
}


program e;

var
    n, m, ld, count : longint;
    
begin

    read(n, m);

    count := 0;
    
    while(m <> 0) do
        begin
            ld := m mod 10;
            if(n = ld) then inc(count);
            m := m div 10;
        end;
        
    
    if (count <> 0) then writeln(count)
        else writeln('NAO');

end.