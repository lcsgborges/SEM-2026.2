sinal :: Int -> String
sinal n
    | n > 0 = "Positivo"
    | n < 0 = "Negativo"
    | otherwise = "Zero"

analisarIMC :: Double -> Double -> String
analisarIMC peso altura
    | imc < 18.5 = "Abaixo do peso"
    | imc < 25.0 = "Peso ideal"
    | imc < 30.0 = "Sobrepeso"
    where imc = peso / (altura ^ 2)