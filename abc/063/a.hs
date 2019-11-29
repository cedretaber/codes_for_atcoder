main :: IO ()
main = do
    line <- getLine
    putStrLn $ case (sum $ map (\s -> read s :: Int) $ words line) of
        n
            | n < 10 -> show n
            | otherwise -> "error"