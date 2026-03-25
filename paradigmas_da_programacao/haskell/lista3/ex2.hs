-- 2. Crie uma função recursiva em Haskell, com a respectiva definição de tipo, que receba
-- uma lista e a posição do elemento a ser retirado e retorne a lista sem o elemento.









-- 2. Crie uma função recursiva em Haskell, com a respectiva definição de tipo, que receba
-- uma lista e a posição do elemento a ser retirado e retorne a lista sem o elemento.

semE:: [Int]->Int->[Int]
semE (h:r:t) n
    | n /= 0 = h : semE (r:t) (n-1) -- Achando posição a ser retirada
    |otherwise = h:t

main:: IO()
main = do

    let remover = 3
    let lista = [1 .. 10]
    
    print(semE lista remover)



    


















------ ============================================================================================================
semE :: [Int] -> Int -> [Int]
semE (h:t) 0 = t  -- Quando a posição a ser removida é 0, removemos o primeiro elemento e retornamos a cauda.
semE (h:t) n = h : semE t (n - 1)  -- Caso recursivo: mantemos o primeiro elemento e continuamos com a cauda, decrementando n.

main :: IO ()
main = do
    let remover = 3  -- Posição do elemento a ser removido.
    let lista = [1..10]  -- Lista de exemplo.
    
    print (semE lista remover)  -- Exibe a lista com o elemento removido.
