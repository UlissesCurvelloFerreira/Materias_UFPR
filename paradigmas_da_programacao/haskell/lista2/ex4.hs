-- 4. Construa uma função que some os elementos pares de uma lista
somaPar :: [Int] -> Int
somaPar [] = 0                -- Caso 1: Lista vazia.
somaPar(h:t)
    | even h = h + somaPar t -- Caso 2: Usanso even que diz se é par ou n.
    | otherwise = somaPar t    -- Caso 3: Ignora o elemento.

main :: IO ()
main = do
    let lista = [1 .. 100000]
    print (somaPar lista)
