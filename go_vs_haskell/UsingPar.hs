import Control.Parallel

import Text.Printf

double :: Int -> Int
double = (*2)

main =
    let x = double 10
        y = double 20
        z = 30 + 40
        answer :: String
        answer = x `par` y `par` z `par` printf "%d + %d + %d = %d" x y z (x+y+z)
    in printf "%s\n" answer

