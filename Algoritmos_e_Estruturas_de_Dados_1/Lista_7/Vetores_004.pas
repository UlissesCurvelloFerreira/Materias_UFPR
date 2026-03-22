{
  Programa em Free Pascal:

  Objetivo:
  1. Ler um inteiro positivo n.
  2. Ler n números inteiros e armazená-los em um vetor.
  3. Determinar os números distintos na sequência, mantendo a ordem relativa de aparição.
  4. Imprimir a sequência de números distintos.
  5. Para cada número distinto, imprimir quantas vezes ele ocorre na sequência original.
  6. Utilizar funções e procedimentos para organizar o código e vetores auxiliares para verificar e contar ocorrências.

  Exemplo de entrada:
  5
  3 1 2 2 3

  Saída esperada:
  a sequencia tem 3 numeros distintos: 3 1 2
  3 ocorre 2 vezes
  1 ocorre 1 vez
  2 ocorre 2 vezes
}


program ex004;
type vetor = array[0..200] of integer;
var
    vetorNumeros: vetor;
    vetorDigitos: vetor;
    vetorDistintos: vetor;
    qt_n, qt_d: integer;


// Insere ocorrências
procedure adicionaOcorrencias(var v_dig: vetor; valor: integer);
begin
    v_dig[valor] := v_dig[valor] + 1;
end;


// Insere valores no vetor distinto
procedure insereDistinto(var v_dis: vetor; var tam: integer; valor: integer);
var 
    i: integer;
    validador: boolean;
begin
    validador := true;
    for i:=0 to tam do
    begin
        if (valor = v_dis[i]) and (i <> 0) then validador := false;
    end;
    if validador then
    begin
        v_dis[tam + 1] := valor;
        tam := tam + 1;
    end;
end;


// Lê e coloca numeros em um array
procedure leiaNumeros(var v: vetor; var tam: integer);
var i: integer;
begin
    read(tam);
    tam := tam - 1;
    for i := 0 to tam do
    begin
        read(v[i]);
        adicionaOcorrencias(vetorDigitos, v[i]);
        insereDistinto(vetorDistintos, qt_d, v[i]);
    end;
end;


// Resultados
procedure resultados(v_dig, v_dis: vetor; tam_v_dis: integer);
var 
    i, j: integer;
    validador: boolean;
begin
    validador := true;
    if tam_v_dis = 0 then validador := false;
    if validador then
    begin
        if(tam_v_dis > 1) then write('a sequencia tem ', (tam_v_dis), ' numeros distintos: ')
        else write('a sequencia tem ', (tam_v_dis), ' numero distinto: ');
        for j:=1 to tam_v_dis do
        begin
            write(v_dis[j], ' ');
        end;
        writeln();
        for i:=1 to tam_v_dis do
        begin
            if(v_dig[v_dis[i]] <> 1) then writeln(v_dis[i], ' ocorre ', v_dig[v_dis[i]], ' vezes')
            else writeln(v_dis[i], ' ocorre ', v_dig[v_dis[i]], ' vez');
        end;
    end
    else writeln('vetor vazio');
end;


// Imprime valores de um vetor
procedure imprimaNumeros(v: vetor; tam: integer);
var i: integer;
begin
    if tam > 0 then
    begin
        for i:=0 to tam-1 do
        begin
            write(v[i], ' ');
        end;
    end
    
    
    else write('vetor vazio');
    writeln();
end;


// Programa principal
begin
    leiaNumeros(vetorNumeros, qt_n);
    resultados(vetorDigitos, vetorDistintos, qt_d);
end.