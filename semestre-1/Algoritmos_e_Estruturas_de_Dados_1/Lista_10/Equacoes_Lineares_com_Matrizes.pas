{
  Um vetor real X com n elementos é apresentado como resultado de um sistema de equações lineares Ax = B,
  onde:
  - A é uma matriz real m×n representando os coeficientes do sistema.
  - B é um vetor real de m elementos representando os lados direitos das equações.

  Faça um programa em Free Pascal que:
  1. Leia os valores de m e n.
  2. Leia o vetor X com n elementos.
  3. Leia a matriz A de dimensão m×n.
  4. Leia o vetor B de m elementos.
  5. Verifique se X é realmente solução do sistema Ax = B.
  6. Imprima "sim" caso X seja solução, ou "não" caso contrário.

  Observação:
  - Como comparações entre números reais podem ser problemáticas,
    utilize uma margem de erro ao verificar a igualdade.

  Exemplo de entrada:
  3 3
  1 3 2
  2 1 -3
  -1 3 2
  3 1 -3
  -1 12 0

  Saída esperada:
  sim
}


program SistemaLinear;

const
  EPSILON = 1e-6;

var
  m, n: integer;
  X: array[1..100] of real;
  A: array[1..100, 1..100] of real;
  B: array[1..100] of real;
  soma: real;
  i, j: integer;
  ehSolucao: boolean;

begin
  { Leitura do tamanho da matriz }
  read(m);
  read(n);

  { Leitura do vetor X (solucao candidata) }
  for j := 1 to n do
    read(X[j]);

  { Leitura da matriz A }
  for i := 1 to m do
    for j := 1 to n do
      read(A[i][j]);

  { Leitura do vetor B (lado direito) }
  for i := 1 to m do
    read(B[i]);

  { Verifica se A*X = B para cada equacao }
  ehSolucao := true;

  for i := 1 to m do
  begin
    soma := 0;
    for j := 1 to n do
      soma := soma + A[i][j] * X[j];

    if Abs(soma - B[i]) > EPSILON then
    begin
      ehSolucao := false;
      break;
    end;
  end;

  if ehSolucao then
    writeln('sim')
  else
    writeln('não');

end.