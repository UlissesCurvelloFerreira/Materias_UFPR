-- 12. O superfatorial de um número N é definida pelo produto dos N primeiros fatoriais de N. 
--Assim, o superfatorial de 4 é sf(4) 1!2!3!4! 288 Faça uma função recursiva que receba um 
--número inteiro positivo N e retorne o superfatorial desse número.
--Esta função deve chamar outra função recursiva que calcula o fatorial de um número.


-- Função para calcular o fatorial de um número
fatorial :: Int -> Int
fatorial 0 = 1                                       -- Caso base: fatorial de 0 é 1
fatorial n = n * fatorial (n - 1)                    -- Caso recursivo: n * fatorial de (n-1)

-- Função para calcular o superfatorial de N
superfatorial :: Int -> Int
superfatorial 0 = 1                                  -- Caso base: superfatorial de 0 é 1 (por convenção)
superfatorial n = fatorial n * superfatorial (n - 1) -- Calcula o superfatorial

main :: IO ()
main = do
  let n = 4
  print (superfatorial n)
