-- 2. Construa uma função que remova o primeiro elemento de uma lista.
removeP :: [Int] -> [Int]
removeP [] = []             -- Caso 1: Lista vazia.
removeP (h:t) = t           -- Caso 2: Lista com elementos.
                            -- Poderia fazer assim: removeP (_:t) = t
main :: IO ()
main = do
  let lista = [1 .. 10]
  print (removeP lista) 
