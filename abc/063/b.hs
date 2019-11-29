import Data.List

main :: IO ()
main = do
    line <- getLine
    putStrLn $ if (length line) == (length $ nub line)
        then "yes"
        else "no"