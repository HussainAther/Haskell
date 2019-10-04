infixr 5 >*>

type Parse a b = [a] -> [(b, [a])

none :: Parse a b
none inp = []

succeed :: b -> Parse a b
succeed val inp = [(val, inp)]

token :: Eq a => a -> Parse a a
token t = spot (==t)

spot :: (a -> Bool) -> Parse a a
spot p (x:xs)
  | p x          = [(x, xs)]
  | otherwise    = [] 
spot p []        = []
