{
  Programa em Free Pascal:

  Objetivo:
  1. Ler um inteiro positivo n.
  2. Ler n valores inteiros e armazená-los em um vetor.
  3. Verificar se o vetor está em ordem crescente:
     - Imprimir "sim" se estiver ordenado.
     - Imprimir "nao" caso contrário.
  4. Imprimir o vetor na ordem inversa da leitura, independentemente da ordenação.
  5. Se n = 0, imprimir "vetor vazio".
  6. Utilizar funções e procedimentos para organizar o código.

  Exemplos de entrada e saída:

  Entrada 1:
  5
  -2 -7 7 2 1
  Saída:
  nao
  1 2 7 -7 -2

  Entrada 2:
  7
  1 3 4 8 8 10 15
  Saída:
  sim
  15 10 8 8 4 3 1

  Entrada 3:
  0
  Saída:
  vetor vazio
}


program teste;

type vetor= array[1..200]of longint;

var n:longint;
    v:vetor;


procedure leitor(var v:vetor; var tam:longint);
var i:longint;
begin
    for i:=1 to tam do
        read(v[i]);
end;

function verifica(var v :vetor; var tam:longint):string;
var i, estado, aux:longint;
begin
    estado:=0;
    aux:=0;
    for i:=1 to tam do
    begin
        if (i > 1) and (v[i] < aux) then
            estado:=1
        else if (i=1)then
            aux:=v[i];
    end;
    if (estado=0)then
        verifica:='sim'
    else
        verifica:='nao';
    writeln(verifica);
end;


procedure vetor_oposto(var v: vetor; tam: longint);
var i, guarda, aux, destino: longint;
begin
    guarda:=tam;
    destino:=tam div 2;
    for i:=1 to destino do
    begin
        aux:= v[i];
        v[i] := v[guarda];
        v[guarda] := aux;
        guarda := guarda -1;
    end;
end;

procedure imprime(var v:vetor; var n:longint);
var i:longint;
begin
    for i:=1 to n do
        write(v[i], ' ');
end;

begin
    read(n);
    if n>0 then
    begin
        leitor(v, n);
        verifica(v, n);
        vetor_oposto(v, n);
        imprime(v, n);
    end
    else
        writeln('vetor vazio')
end.