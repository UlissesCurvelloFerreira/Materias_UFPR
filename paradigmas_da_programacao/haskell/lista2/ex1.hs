-- 1. Construa uma fun¸c˜ao que inverta uma lista.
inverterL :: [Int] -> [Int]
inverterL [] = []                     -- Caso 1: Lista vazia.
inverterL [x] = [x]                   -- Casa 2: Lista com um elemento.
inverterL (h:t) = inverterL t ++ [h]  -- Casa 3: Lista invertida recursivamente

main :: IO ()
main = do
  let lista = []
  print (inverterL lista) 