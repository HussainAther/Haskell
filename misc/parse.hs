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

alt :: Parse a b -> Parse a b -> Parse a b
alt pl p2 inp = pl inp ++ p2 inp

(>*>) :: Parse a b -> Parse a c -> Parse a (b,c) 
(>*>I pl p2 inp
  = [((y,~,)re11121 I (y,rernl) <- pl inp , (z,rem2) <- p2 remi 1 

build :: Parse a b -> (b -> c) -> Parse a c
build p f inp = [ (f x,rem) I (x,rern) <- p inp ]

list :: Parse a b -> Parse a [b]
list p = (succeed []) 'alt'
         ((p >*> list p) 'build' (uncurry (:)))
