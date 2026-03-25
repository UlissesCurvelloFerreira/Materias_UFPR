-- 11. Função que gira uma lista N lugares para a esquerda
giraEsquerda :: [a] -> Int -> [a]
giraEsquerda lista n = drop nMod lista ++ take nMod lista
  where
    nMod = n `mod` length lista  -- Garantir que n não ultrapasse o tamanho da lista

main :: IO ()
main = do
    let lista = [1, 2, 3, 4, 5]
    let n = 2
    putStrLn "Lista original:"
    print lista
    putStrLn ("Lista girada " ++ show n ++ " lugares para a esquerda:")
    print (giraEsquerda lista n)
