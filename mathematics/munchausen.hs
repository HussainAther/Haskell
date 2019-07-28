import Data.List (unfoldr)

--A Munchausen number is a natural number n the sum of whose digits in base 10, each raised the 
--power of itself, equals n. E.g., 3435 = 3^3 + 4^4 + 3^3 + 5^5
 
isMunchausen :: Integer -> Bool
isMunchausen n = (n ==) $ sum $ map (\x -> x^x) $ unfoldr digit n where
  digit 0 = Nothing
  digit n = Just (r,q) where (q,r) = n `divMod` 10
 
main :: IO ()
main = print $ filter isMunchausen [1..5000]
