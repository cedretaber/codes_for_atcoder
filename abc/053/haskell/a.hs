
main = do
    x <- readLn
    putStrLn $ if x < 1200 then "ABC" else "ARC"