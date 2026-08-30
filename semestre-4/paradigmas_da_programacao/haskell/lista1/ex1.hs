-- 1. Função recursiva para inverter um número inteiro usando dois parâmetros
inverterNumero :: Int -> Int -> Int
inverterNumero 0 acumulado = acumulado -- Caso base: quando o número for 0, retorna o acumulado
inverterNumero n acumulado = inverterNumero (n `div` 10) (acumulado * 10 + (n `mod` 10))

main :: IO ()
main = do
  let n = 1234
  print (inverterNumero n 0) 
  -- Saída: 4321
