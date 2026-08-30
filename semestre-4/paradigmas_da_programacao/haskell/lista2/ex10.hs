-- 10: Construa uma função que dados dois índices, i e k, a fatia é a lista que contém os elementos 
-- entre os elementos  i-ésimo e o k-ésimo da lista original (ambos os limites incluídos). 
-- Comece a contar os elementos com 1.

intervaloL :: [Int] -> Int -> Int -> [Int]
intervaloL [] i  k = [-1]   -- Caso 1: lista vazia.
intervaloL [x] i k = [x]    -- Casa 2: lisa com apenas um elemento.
intervaloL (h:t) i k        -- Caso 3: 
    | i /= 0 = intervaloL t i-1 k
    | k /= 0 = t: intervaloL t i k-1
    | otherwise = [t]


main :: IO ()
main = do
    let ini = 3
    let fim = 17
    let lista = [1 .. 20]
    
    print(intervaloL lista ini fim)