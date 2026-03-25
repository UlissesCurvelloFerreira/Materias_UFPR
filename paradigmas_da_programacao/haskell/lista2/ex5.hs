-- 5. Construa uma função que some os elementos em posições pares de uma lista.
-- (A primeira posição da lista é a posição 1).

somaParPos :: [Int] -> Int
somaParPos [] = 0                     -- Caso 1: Lista vazia, retorna 0
somaParPos [x] = 0                    -- Caso 2: Lista com um único elemento, retorna 0 (não há posição par)
somaParPos (x:y:xs) = y + somaParPos xs -- Caso recursivo: Soma o elemento na posição 2, 4, 6, ...

main :: IO ()
main = do
    let lista = [1 .. 10]
    print (somaParPos lista)
