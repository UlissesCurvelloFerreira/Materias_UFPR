-- 14. Escreva, usando a linguagem haskell, uma função recursiva, ImprimeSerie(i.j.k. inteiro),
-- que imprime na tela a série de valores do intervalo [i,j], com incremento k.

-- Função recursiva que imprime a série de números no intervalo [i, j] com incremento k
serie :: Int -> Int -> Int -> IO ()
serie i j k
    | i > j     = return ()             -- Caso base: se i for maior que j, termina a recursão
    | otherwise = do
        serie (i + k) j k               -- Chama a recursão com o próximo valor de i
        putStrLn (show i)               -- Imprime o valor de i

main :: IO ()
main = do
  let i = 1  -- Valor inicial
  let j = 20 -- Valor final
  let k = 2  -- Incremento
  serie i j k

