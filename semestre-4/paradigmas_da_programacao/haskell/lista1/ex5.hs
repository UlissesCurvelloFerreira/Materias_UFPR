-- 5. Função recursiva para contar quantas vezes o dígito K ocorre em N
contarDigito :: Int -> Int -> Int
contarDigito 0 k = 0                                      -- Caso base: se o número N for 0
contarDigito n k
  | n `mod` 10 == k  = 1 + contarDigito (n `div` 10) (k)  -- Se o último dígito de N for igual a K, conta 1
  | otherwise        = contarDigito (n `div` 10) (k)      -- Se não, apenas chama a recursão para o resto do número


main :: IO ()
main = do
    let numero = 10000
    let digito = 0     
    print (contarDigito numero digito)                  -- Imprime quantas vezes o dígito aparece
