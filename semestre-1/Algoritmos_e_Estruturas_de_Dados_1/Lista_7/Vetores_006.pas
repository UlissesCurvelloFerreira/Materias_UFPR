{
  Programa em Free Pascal:

  Objetivo:
  1. Ler uma sequência de códigos de operação e valores:
     - Código 0: fim da entrada.
     - Código 1: inserção do valor no vetor.
     - Código 2: remoção do valor do vetor.
  2. As inserções devem manter o vetor sempre ordenado.
  3. Após cada operação válida, imprimir o vetor resultante:
     - Se o vetor estiver vazio, imprimir "vazio".
     - Valores reais devem ser impressos com uma casa decimal.
  4. Limitações e erros:
     - O vetor pode conter no máximo 200 elementos.
     - Inserção que exceda 200 elementos: imprimir "erro".
     - Remoção de valor inexistente: imprimir "erro".
     - Código de operação inválido: ignorar e ler próximo código até receber 0, 1 ou 2.
  5. Ao final, imprimir o vetor final resultante.
  6. Utilizar funções e procedimentos para organizar o código.

  Exemplo de entrada:
  1
  45.3
  1
  34.3
  4
  9
  1
  40.8
  2
  11.9
  2
  34.3
  0

  Saída esperada:
  45.3
  34.3 45.3
  34.3 40.8 45.3
  erro
  40.8 45.3
  40.8 45.3
}



program ex;

type vetor = array [0..200] of real;

var v : vetor;
    codigo , tam : longint;
    valor : real;
 
procedure insercao (var v : vetor ; var tam : longint ; var valor : real);
var i : longint;

begin
    v[0]:= valor;
    i:= tam; 
    while valor < v[ i ] do 
    begin
        v[ i+1]:= v[ i ] ;
        i:= i - 1;
    end;
    v[i+1]:= valor; 
    tam:= tam + 1;
end;


procedure imprime (var v : vetor ; var tam : longint);
var i : longint;

begin
    if tam <> 0 then
    begin
        for i:=1  to tam do
            write(v[i]:0:1,' ');
    writeln( );
    end
    else
        writeln('vazio');
end;



procedure remocao (var v : vetor ; var tam : longint; var valor : real);
var i, y, j: longint;
begin
    y:= 0;
    for i:= 1 to tam do
    begin
        if v[i] = valor then
        begin
            for j:= i to tam do
                v[j]:= v[j+1];
            y:= 1;
        end;
    end;
    if y <> 1 then
        writeln ('erro')
    else
    begin
        tam:= tam - 1;
        imprime (v , tam);
    end;
end;


begin
    tam:= 0;
    read(codigo);
    while codigo <> 0 do
    begin
        if (codigo = 1) or (codigo = 2) then
        begin
            if codigo = 1 then
            begin
                if tam < 200 then
                begin
                    read(valor);
                    insercao(v , tam , valor);
                    imprime (v , tam);
                end
                else
                    writeln('erro');
            end
            else if codigo = 2 then
            begin
                if tam < 200 then
                begin
                    read(valor);
                    remocao(v , tam , valor);
                end
                else
                    writeln('erro');
            end;
        end;
        read(codigo);
    end;
    imprime(v, tam);
end.
