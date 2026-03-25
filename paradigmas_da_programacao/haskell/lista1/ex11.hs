{-v1-}
-- 11. A função fatorial duplo é definida como o produto de todos os números naturais impares de 1 até algum número natural impar N. 
-- Assim, o fatorial duplo de 5 é 5!! 1 * 3 * 5 = 15 Faça uma função recursiva que receba um número inteiro positivo impar N e 
-- retorne o fatorial duplo desse número. 
-- Esta função deve chamar outra função recursiva que calcula o fatorial de um número.

fatorialDuplo :: Int -> Int
fatorialDuplo n 
    | n <= 0 = -1                                   -- Caso 1: Se for n == 0!! indefinido.
    | n == 1 = 1                                   -- Caso 1: Se for n == 0!! indefinido.
    | otherwise =  n * fatorialDuplo(n - 2)        -- Caso 2: Se for n != 0 calcula o fatorial duplo 

main :: IO ()
main = do
  let n = 10
  print(fatorialDuplo n)


{-v2====================================================================================================================================-}
-- 11. Função recursiva para calcular o fatorial duplo
fatorialDuplo :: Int -> Int
fatorialDuplo n
    | n <= 0    = 1                           -- Caso base: fatorial duplo de 0 ou negativo é 1
    | n == 1    = 1                           -- Caso base: fatorial duplo de 1 é 1
    | otherwise = n * fatorialDuplo (n - 2)   -- Caso recursivo: multiplica n pelos ímpares anteriores

main :: IO ()
main = do
    let n = 15  -- Substitua por qualquer número ímpar positivo
    if odd n then
        print (fatorialDuplo n)               -- Calcula o fatorial duplo se n for ímpar
    else
        putStrLn "Erro: O número deve ser ímpar e positivo."
