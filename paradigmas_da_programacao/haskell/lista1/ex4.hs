-- 4. Função recursiva para inverter a ordem dos elementos de uma lista de números reais
inverterLista :: [Double] -> [Double]
inverterLista [] = []                           -- Caso base: lista vazia, retorna lista vazia
inverterLista (h:t) = inverterLista t ++ [h]    -- Caso C.C.: inverte o restante da lista e 
                                                -- adiciona o primeiro elemento no final

main :: IO ()
main = do
    
    let vetor = [1.0 ,2.0 .. 20.0]      -- Define um vetor de 20 números reais
    
    putStrLn "Vetor Original:"          -- Define um vetor de 20 números reais
    print vetor
    
    putStrLn "\nVetor Invertido:"       -- Inverte o vetor e imprime
    print (inverterLista vetor)
