-- 3. Função recursiva para calcular o somatório dos números de 1 até N
somatorioRegressivo :: Int -> Int
somatorioRegressivo 0 = 0                               -- Caso base: quando N é 0, o somatório é 0;
somatorioRegressivo n = n + somatorioRegressivo (n - 1) -- Caso C.CSoma N com o somatório de (N-1);

-- Função principal.
main :: IO ()
main = do
    let n = 10                                          -- Define o número N para o somatório;
    print (somatorioRegressivo n)                       -- Chama a função e imprime o resultado;