-- 2. Função principal para inverter um número
somatorio :: [Int] -> Int
somatorio [] = 0                            -- Caso lista vazia, retorna 0;
somatorio (h:t) = h + somatorio t           -- Caso lista cheia, somatório;

main :: IO ()
main = do
    let lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] -- Chama a função e imprime o resultado, que será 321
    print (somatorio lista)
