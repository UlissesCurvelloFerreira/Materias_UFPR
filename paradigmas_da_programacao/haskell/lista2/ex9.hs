-- 9. Construa uma função que divida uma lista em duas partes; 
-- é fornecido o comprimento da primeira parte.

-- Função para dividir uma lista em duas partes
dividaL :: [Int] -> Int -> ([Int], [Int])
dividaL [] _ = ([], [])  -- Caso base: lista vazia retorna duas listas vazias.
dividaL xs 0 = ([], xs)  -- Caso base: quando n = 0, retorna toda a lista como a segunda parte.
dividaL (h:t) n = 
    let (parte1, parte2) = dividaL t (n - 1)  -- Divide recursivamente
    in (h : parte1, parte2)  -- Adiciona o elemento atual à primeira parte.

main :: IO ()
main = do
    let tam = 3
    let lista = [1 .. 10]
    let (parte1, parte2) = dividaL lista tam  -- Chama a função com o tamanho desejado
    putStrLn "Primeira parte da lista:"
    print parte1
    putStrLn "Segunda parte da lista:"
    print parte2
