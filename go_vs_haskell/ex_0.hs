-- Corey O'Connor
-- 2013-08-17

import Control.Monad
import Control.Concurrent
import Control.Concurrent.Chan

import Text.Printf

-- double doubles the given int, then sends it through the given channel
double :: Chan Int -> Int -> IO ()
double ch n = writeChan ch (n*2)

main = do
    ch <- newChan
    answer <- newChan

    forkIO $ double ch 10
    forkIO $ double ch 20
    forkIO $ (\a b -> writeChan ch (a + b)) 30 40
    forkIO $ do
        [x, y, z] <- replicateM 3 $ readChan ch
        writeChan answer $ (printf "%d + %d + %d = %d" x y z (x+y+z) :: String)

    printf "%s\n" =<< readChan answer

