import Data.DList
import Data.List.Split

main :: IO ()
main = do
    n <- (splitOn " ") =<< getLine
    putStrLn $ show n