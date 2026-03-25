-- 6. Construa uma função que receba uma lista e um número ’n’ e insira um elemento na
-- n-ésima posição da lista.
{-v1-}
inserirNoFim :: [Int] -> Int -> [Int]
inserirNoFim [] x = [x]                     -- Caso base: se a lista estiver vazia, retorna uma lista contendo apenas o elemento.
inserirNoFim (h:t) x = h : inserirNoFim t x  -- Caso recursivo: percorre a lista até o final, depois insere 'x'.

main :: IO ()
main = do
  let lista = [1, 2, 3, 4, 5]
  let elemento = 6
  print (inserirNoFim lista elemento)  -- Esperado: [1, 2, 3, 4, 5, 6]
  
{-v2-}
inserirNaPosicao :: [Int] -> Int -> Int -> [Int]
inserirNaPosicao [] _ x = [x]  -- Caso base: se a lista estiver vazia, retorna a lista contendo apenas o elemento.
inserirNaPosicao (h:t) 1 x = x : h : t  -- Caso recursivo: insere 'x' na posição 1.
inserirNaPosicao (h:t) n x = h : inserirNaPosicao t (n - 1) x  -- Recursão: desce na lista, decrementando 'n' até atingir a posição.

main :: IO ()
main = do
  let lista = [1, 2, 3, 4, 5]
  let n = 3
  let elemento = 10
  print (inserirNaPosicao lista n elemento)  -- Esperado: [1, 2, 10, 3, 4, 5]


