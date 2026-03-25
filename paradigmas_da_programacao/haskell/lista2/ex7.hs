-- 7. Construa uma função que encontre o penúltimo elemento de uma lista.
penultimo:: [Int]->Int
penultimo [] = -1       -- Caso 1: retorna -1 se lista vazia.
penultimo [_] = -2      -- Caso 2: retorna -1 se lista com elemento único.
penultimo [x, _] = x    -- Caso 3: retornao penultimo elemento.
penultimo (_:t) = penultimo t

main:: IO()
main = do
    --let lista = []
    --let lista = [1] 
    let lista = [1 .. 20] 
    print(penultimo lista)