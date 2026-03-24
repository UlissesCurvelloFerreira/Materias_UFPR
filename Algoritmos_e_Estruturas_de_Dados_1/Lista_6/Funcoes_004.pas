{
Enunciado:
Faça uma função que receba como parâmetro um número inteiro e retorne true se ele for primo e false em caso contrário. Teste sua função usando o código abaixo, que imprime todos os primos entre 1 e 10000.

program testa_se_primo;
var i: longint;

(* coloque aqui o codigo da sua funcao que testa se eh primo *)

begin
    for i:= 2 to 10000 do
        if eh_primo (i) then
            writeln (i);
end.
}



program testa_se_primo;
var i:longint;

(* coloque aqui o codigo da sua funcao que testa se eh primo *)
function eh_primo(num:longint):boolean;
var conta, verifica, k, i:longint;
begin
    verifica:=0;
    k:=0;
    i:=1;
    while k <> (num+1) do
    begin
        conta:= num mod i;
        if conta=0 then
            verifica:=verifica+1;
        k:=k+1;
        i:=i+1;
    end;
    if (verifica = 2) or (num = 1) then
        eh_primo:=true;
    
end;
begin
    for i:=1 to 10000 do
        if eh_primo(i)then
            writeln(i);
end.