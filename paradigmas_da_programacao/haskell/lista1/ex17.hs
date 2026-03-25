-- 17. Escreva uma função recursiva que calcule a soma dos digitos de um número inteiro.
-- Por exemplo, se a entrada for 123, a saida deverá ser 1+2+3=6.

-- Função recursiva somar os algorismos de uma função
somaAlga :: Int -> Int
somaAlga 0 = 0
somaAlga n = somaAlga (n `div` 10) + (n `mod` 10)
-- se n=123  somaAlga ( 12,3 )     + (3)


main :: IO ()
main = do
  let n = 123 -- 1 + 2 + 3 = 6
  print (somaAlga n)
