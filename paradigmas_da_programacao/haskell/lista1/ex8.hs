-- 8. Função recursiva que imprime números naturais de 0 a N em ordem crescente
imprimirNumeros :: Int -> IO ()
imprimirNumeros 0 = putStrLn "0"   -- Caso base: imprime 0
imprimirNumeros n = do
    putStrLn (show n)              -- Imprime o número atual
    imprimirNumeros (n - 1)        -- Chama recursivamente para imprimir os números menores

main :: IO ()
main = do
    let n = 5                      -- Define o valor de N
    imprimirNumeros n              -- Chama a função para imprimir os números


-- Dentro do main se colocar "N" no caso n maiúsculo da erro, mas n sei o por que