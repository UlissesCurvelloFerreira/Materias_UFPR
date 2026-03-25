{
Enunciado:
Faça um programa Pascal que leia do teclado um valor inteiro representando o ano de nascimento de uma pessoa.
Com esse dado, o programa deve fazer o seguinte:

- Calcular e imprimir sua idade, considerando que estamos no ano de 2020;
- Verificar e imprimir SIM ou NAO se a pessoa já tem idade para votar (16 anos ou mais);
- Verificar e imprimir SIM ou NAO se a pessoa já tem idade para conseguir a carteira de habilitação (18 anos ou mais).

Exemplos:

Entrada 1:
2002
Saída Esperada 1:
18
SIM
SIM

Entrada 2:
2005
Saída Esperada 2:
15
NAO
NAO
}


program qualIdade;

var idade, conta:longint;

begin
    read(idade);
    conta:=2020-idade;
    writeln(conta);
    if conta >= 16 then
        writeln('SIM')
    else
        writeln('NAO');
        
    if conta >= 18 then
        writeln('SIM')
    else
        writeln('NAO');
end.