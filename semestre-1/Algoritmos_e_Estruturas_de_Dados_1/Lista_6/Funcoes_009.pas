{
Enunciado:
Faça uma função que calcule a média ponderada com pesos respectivamente 1, 2 e 3 para as provas 1, 2 e 3. Faça também outra função que decida se um aluno foi aprovado ou reprovado, sabendo que a aprovação deve ter a média final maior ou igual a 50. As notas das provas e a média são valores inteiros entre zero e 100. Você pode testar sua procedure usando o código abaixo:

Exemplo de entrada
3

100 40 5
5 40 100
50 50 50

Saída esperada
aluno 1 reprovado com media: 32

aluno 2 aprovado com media: 64

aluno 3 aprovado com media: 50

program media_alunos;
var i, n, p1, p2, p3, media: longint;

(* coloque aqui o codigo da sua funcao que calcula media ponderada *)

(* coloque aqui o codigo da funcao que decide pela aprovacao/reprovacao *)

begin
    read (n);
    for i:= 1 to n do
    begin
        read (p1, p2, p3);
        media:= media_ponderada (p1, p2, p3);
        if aprovado (media) then
            writeln ('aluno ',i,' aprovado com media: ', media)
        else
            writeln ('aluno ',i,' reprovado com media: ', media);
    end;
end.
}

program media_alunos;
var i, n, p1, p2, p3, media: longint;

(* coloque aqui o codigo da sua funcao que calcula media ponderada *)
function ponderada(n1, n2, n3:longint):longint;
var conta:longint;
begin
    conta:=(((n1)+(n2*2)+(n3*3))div 6);
    ponderada:=conta;    
end;

(* coloque aqui o codigo da funcao que decide pela aprovacao/reprovacao *)
function aprovado(dado:longint):boolean;
begin
    if dado > 50 then
        aprovado:=true
    else
        aprovado:=false;
end;
begin
    read (n);
    for i:= 1 to n do
    begin
        read (p1, p2, p3);
        media:=ponderada(p1, p2, p3);
        
        if aprovado(media) then
            writeln('aluno ',i,' aprovado com media: ', media)
        else
            writeln('aluno ',i,' reprovado com media: ', media);
    end;
end.