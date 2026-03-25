-- 1. Crie uma função em Haskell, com a respectiva definição de tipo, que receba uma String e verifique se é Palíndromo ou não. 
-- Podem ser criadas outras funções, com as respectivas definições de tipo, para realizar a tarefa.

palindromo:: String->String  -- S não s
palindromo a
    |a == reverse a = "Sim"  -- Operador reverse inverte um palavra
    |otherwise = "Nao"


main:: IO()
main = do
    
    let word1 = "anaa"
  
    print(palindromo word1 )



//======================= SEM REVERSE =========================//


palindromo :: String -> String
palindromo [] = "Sim"  -- Caso base: lista vazia ou com um único caractere
palindromo [x] = "Sim"  -- Caso base: uma lista com um único caractere é sempre palíndromo
palindromo (x:xs) 
    | x == last xs = palindromo (init xs)  -- Compara o primeiro e último elemento
    | otherwise = "Não"  -- Se algum par de caracteres não for igual, não é palíndromo

main :: IO ()
main = do
    let word1 = "anaa"
    putStrLn (palindromo word1)
