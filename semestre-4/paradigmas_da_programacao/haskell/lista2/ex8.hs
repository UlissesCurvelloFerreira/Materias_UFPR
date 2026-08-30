-- 8. Construa uma função que elimine duplicatas consecutivas dos elementos da lista.

eliminaD:: [Int]->[Int]
eliminaD [] = [-1]              -- Caso 1: retorna -1 se lista vazia.
eliminaD [x] = [x]              -- Caso 2: retorna "x" se lista com elemento único [x].
eliminaD (a:b:t) 
    |a == b = eliminaD(b:t)     -- Caso 3: retorna a lista sem duplicatas.
    |otherwise = a: eliminaD(b:t) -- operados ":" usado para unir elementos a lista.


main:: IO()
main = do
    let lista = [1, 1,  2, 5, 7, 3, 3, 9, 0, 1, 2, 2]
                -- [1, 2, 5, 7, 3, 8, 9, 0, 1, 2]
    print(eliminaD lista)