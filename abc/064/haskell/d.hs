
main :: IO ()
main = do
    _ <- getLine
    s <- getLine
    putStrLn $ solve s

solve :: String -> String
solve s =
    impl 0 "" "" s
    where
        impl :: Int -> String -> String -> String -> String
        impl p k kk ""
            | p == 0 = kk ++ (reverse k)
            | otherwise = impl (p-1) (')':k) kk ""
        impl p k kk ('(':cs)
            | p == 0 = impl (p+1) "(" (kk ++ (reverse k)) cs
            | otherwise = impl (p+1) ('(':k) kk cs
        impl p k kk (')':cs)
            | p == 0 = impl p (')':k) ('(':kk) cs
            | otherwise = impl (p-1) (')':k) kk cs