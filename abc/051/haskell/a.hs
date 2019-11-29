
import Data.List
import Data.List.Split

main :: IO ()
main = (fmap ((intercalate "") . (splitOn ",")) getLine) >>= putStrLn