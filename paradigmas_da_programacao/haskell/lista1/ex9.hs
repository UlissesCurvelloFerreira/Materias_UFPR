-- 9. Faça uma função recursiva que receba um número inteiro positivo par N e 
--imprima todos os números pares de 0 até N em ordem crescente.

imprimirPares :: Int -> IO ()
imprimirPares n
  | n < 0 = return ()                       -- Caso base: não faz nada se N for negativo
  | n `mod` 2 /= 0 = imprimirPares (n - 1)  -- Caso ímpar: ajusta para o par anterior
  | otherwise = do 
    imprimirPares (n - 2) 
    putStrLn (show n)                       -- Caso par: Imprime o número atual

main :: IO ()
main = do
  let n = 11 
  imprimirPares n
