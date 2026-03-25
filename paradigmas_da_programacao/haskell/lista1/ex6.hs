-- 6. A multiplicação de dois números inteiros pode ser feita atravésde somas sucessivas.
-- Proponha um algoritmo recursivo Multip_Rec(n1, n2) que calcule a multiplicação de dois inteiros.

multiplicacao :: Int -> Int -> Int
multiplicacao 0 _ = 0                                   -- Caso base: se o número N1 for 0
multiplicacao n1 n2 = n2 + multiplicacao (n1 - 1) (n2)  -- Caso C.C: se o número N1 diferente


main :: IO ()
main = do
    let n1 = 5
    let n2 = 3     
    print (multiplicacao n1 n2)                         -- Imprime valor de retorno a função


========================PARA NEGATIVOS E POSITIVOS============================================================
multiplicacao :: Int -> Int -> Int
multiplicacao 0 _ = 0                                   -- Caso base: se n1 for 0
multiplicacao n1 n2
  | n1 > 0    = n2 + multiplicacao (n1 - 1) n2         -- Se n1 for positivo, soma n2 com recursão
  | n1 < 0    = -n2 + multiplicacao (n1 + 1) n2        -- Se n1 for negativo, soma -n2 (o negativo de n2)

main :: IO ()
main = do
    let n1 = 5
    let n2 = 3     
    print (multiplicacao n1 n2)                         -- Imprime valor de retorno a função
