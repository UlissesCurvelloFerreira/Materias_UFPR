-- 16. Escreva uma função recursiva que calcule a soma de dois números naturais, 
-- através de incrementos sucessivos (Ex.: 3+2=++(++3)).

-- Função recursiva que converte um número decimal para binário
somaD :: Int -> Int -> Int 
somaD 0 b = b 
somaD a b = 1 + somaD (a-1) b   -- Chamada recursiva para incrementar 1

main :: IO ()
main = do
  let n1 = 2
  let n2 = 3
  print (somaD n1 n2)
