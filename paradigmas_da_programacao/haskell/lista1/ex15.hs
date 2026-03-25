-- 15. Dado um número n na base decimal, escreva uma função recursiva em haskell
--que converte este número para binário.

-- Função recursiva que converte um número decimal para binário
paraBin :: Int -> String
paraBin 0 = "0"                                      -- Caso base: 0 em binário é "0"
paraBin n = paraBin (n `div` 2) ++ show (n `mod` 2)  -- Chamada recursiva

main :: IO ()
main = do
  let n = 100 
  print (paraBin n)
