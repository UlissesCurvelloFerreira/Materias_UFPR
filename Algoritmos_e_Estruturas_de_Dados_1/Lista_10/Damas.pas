{
  Uma matriz D(8 × 8) representa o tabuleiro de um jogo de damas:
  - 0 indica casa vazia
  - 1 indica peça branca
  - -1 indica peça preta

  Supondo que as peças pretas se movem no sentido crescente das linhas,
  determinar as posições das peças pretas que:

  1. Podem tomar peças brancas (prioridade máxima)
  2. Podem mover-se sem tomar peças brancas
  3. Não podem se mover

  Regras:
  - Cada peça só pode ser marcada com uma ação.
  - As peças pretas nunca estarão na última linha do tabuleiro.
  - Se não houver peça para algum movimento, exibir 0 ao invés da posição.
  - A prioridade é sempre "tomar" quando possível.

  Exemplo de Entrada 1:
  -1 0 -1 0 -1 0 -1 0
  0 -1 0 -1 0 -1 0 -1
  -1 0 -1 0 -1 0 -1 0
  0 0 0 0 0 0 0 0
  0 0 0 0 0 0 0 0
  0 1 0 1 0 1 0 1
  1 0 1 0 1 0 1 0
  0 1 0 1 0 1 0 1

  Saída Esperada 1:
  tomar: 0
  mover: 3-1 3-3 3-5 3-7
  ficar: 1-1 1-3 1-5 1-7 2-2 2-4 2-6 2-8

  Exemplo de Entrada 2:
  -1 0 -1 0 -1 0 -1 0
  0 -1 0 -1 0 -1 0 -1
  0 0 -1 0 -1 0 -1 0
  0 -1 0 0 0 0 0 0
  0 0 1 0 0 0 0 0
  0 1 0 0 0 1 0 1
  1 0 1 0 1 0 1 0
  0 1 0 1 0 1 0 1

  Saída Esperada 2:
  tomar: 4-2
  mover: 2-2 3-3 3-5 3-7
  ficar: 1-1 1-3 1-5 1-7 2-4 2-6 2-8
}


program Damas;

uses SysUtils;

var
  D: array[1..8, 1..8] of integer;
  i, j, k: integer;

  { Listas de posicoes para cada categoria }
  tomar:  array[1..64, 1..2] of integer;
  mover:  array[1..64, 1..2] of integer;
  ficar:  array[1..64, 1..2] of integer;

  nTomar, nMover, nFicar: integer;
  podeTomar, podeMover: boolean;

begin
  { Leitura da matriz }
  for i := 1 to 8 do
    for j := 1 to 8 do
      read(D[i][j]);

  nTomar := 0;
  nMover := 0;
  nFicar := 0;

  { Percorre todas as posicoes procurando pecas pretas (-1) }
  for i := 1 to 8 do
  begin
    for j := 1 to 8 do
    begin
      if D[i][j] = -1 then
      begin
        podeTomar := false;
        podeMover := false;

        { Verifica captura: peca branca na diagonal + casa vazia alem }
        { Diagonal: linha+1, col-1 -> linha+2, col-2 }
        if (i + 2 <= 8) and (j - 2 >= 1) then
          if (D[i+1][j-1] = 1) and (D[i+2][j-2] = 0) then
            podeTomar := true;

        { Diagonal: linha+1, col+1 -> linha+2, col+2 }
        if (i + 2 <= 8) and (j + 2 <= 8) then
          if (D[i+1][j+1] = 1) and (D[i+2][j+2] = 0) then
            podeTomar := true;

        { Verifica movimento simples (sem captura) }
        if not podeTomar then
        begin
          { Diagonal: linha+1, col-1 }
          if (i + 1 <= 8) and (j - 1 >= 1) then
            if D[i+1][j-1] = 0 then
              podeMover := true;

          { Diagonal: linha+1, col+1 }
          if (i + 1 <= 8) and (j + 1 <= 8) then
            if D[i+1][j+1] = 0 then
              podeMover := true;
        end;

        { Classifica a peca }
        if podeTomar then
        begin
          inc(nTomar);
          tomar[nTomar][1] := i;
          tomar[nTomar][2] := j;
        end
        else if podeMover then
        begin
          inc(nMover);
          mover[nMover][1] := i;
          mover[nMover][2] := j;
        end
        else
        begin
          inc(nFicar);
          ficar[nFicar][1] := i;
          ficar[nFicar][2] := j;
        end;
      end;
    end;
  end;

  { Saida }

  { Tomar }
  write('tomar: ');
  if nTomar = 0 then
    writeln('0')
  else
  begin
    for k := 1 to nTomar do
    begin
      if k > 1 then write(' ');
      write(tomar[k][1], '-', tomar[k][2]);
    end;
    writeln;
  end;

  { Mover }
  write('mover: ');
  if nMover = 0 then
    writeln('0')
  else
  begin
    for k := 1 to nMover do
    begin
      if k > 1 then write(' ');
      write(mover[k][1], '-', mover[k][2]);
    end;
    writeln;
  end;

  { Ficar }
  write('ficar: ');
  if nFicar = 0 then
    writeln('0')
  else
  begin
    for k := 1 to nFicar do
    begin
      if k > 1 then write(' ');
      write(ficar[k][1], '-', ficar[k][2]);
    end;
    writeln;
  end;

end.