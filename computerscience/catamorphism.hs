--Reduce is a function or method to take values in an array and apply a function to success numbers of the list to produce a single value.
--Demonstrate reduce in Haskell.

main :: IO ()
main =
  putStrLn . unlines $
  [ show . foldr (+)    0  -- sum
  , show . foldr (*)    1  -- product
  , foldr ((++) . show) "" -- concatenation
  ] <*>
  [[1 .. 10]]
