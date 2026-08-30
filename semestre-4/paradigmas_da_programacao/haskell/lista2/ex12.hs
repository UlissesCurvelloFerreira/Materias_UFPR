-- 12. Construa uma função que crie uma lista contendo todos os
-- números inteiros dentro de um determinado intervalo.

listaI :: Int -> Int -> [Int]
listaI a b
    | a > b = []                          -- Caso 1: Se a > b, retorna lista vazia
    | a == b = [a]                        -- Caso 2: Quando a == b, retorna a lista com o único elemento
    | otherwise = (a) : (listaI (a+1) b)  -- Caso 3: Constrói a lista recursivamente
    
-- Usando o operador construtor de listas ":", dado que 'a' tb é uma lista.

main :: IO ()
main = do

    let ini = 3
    let fim = 7
    
    putStrLn "Lista gerada:"
    print (listaI ini fim)
