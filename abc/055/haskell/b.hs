

main = (\n -> putStrLn $ solve n) =<< readLn
    where
        solve :: Int -> Int