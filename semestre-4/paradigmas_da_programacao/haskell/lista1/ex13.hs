-- 13. Crie um programa em Haskell. que contenha uma função recursiva para encontrar o menor elemento em um vetor. 
--A leitura dos elementos do vetor e impressão do menor elemento devem ser feitas no programa principal.

-- Função para calcular o fatorial de um número
menorV :: [Int] -> Int
menorV[x] = x                  -- Caso 1: Lista com apenas um elemento.
menorV (h:t)                   -- Separando em header e tail.
    | h < menorV t = h         -- Caso 2: header sem o menor elemento.
    | otherwise = menorV t                -- Caso 3: Buscar menor elemento.



main :: IO ()
main = do
  let lista = [200, 1212, 22, 1, 2, 323, -9]
  let lista2 = [1 .. 100]
  print (menorV lista2)
