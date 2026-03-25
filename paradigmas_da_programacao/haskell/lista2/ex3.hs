-- 3. Construa uma fun¸c˜ao que remova o último elemento de uma lista.
removeU :: [Int] -> [Int]
removeU [] = []                 -- Caso 1: Lista vazia retorna uma lista vazia
removeU [_] = []                -- Caso 2: Uma lista com um elemento retorna uma lista vazia
removeU (h:t) = h : removeU t   -- Caso 3: Mantém o primeiro elemento e chama recursivamente para o restante

main :: IO ()
main = do
  let lista = [1 .. 10]
  print (removeU lista)