
import Control.Monad
import Data.List

main :: IO ()
main = do
    n <- readLn
    nums <- sequence $ replicate n (readLn :: IO Int)
    putStrLn $ show $ solve nums

solve :: [Int] -> Int
solve nums =
    let (tens, ntens) = partition (\n -> n `mod` 10 == 0) nums in
        if null ntens
            then 0
            else let s = sum nums in
                if s `mod` 10 == 0
                    then s - (head $ sort ntens)
                    else s