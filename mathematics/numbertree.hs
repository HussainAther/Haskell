--Sum a tree of integers
--Recursive solution
sTree ::TreeInt-> Int
sTree Nil = 0
sTree (Nodentlt2) = n + sTree t1 + sTree t2
--Monadic solution
sumTree :: Tree Int -> St Int
sumTree Nil = return 0
sumTree (Node n tl t2) 
  = do num <- return n
       s1 <- sumTreeti
       s2 <- sumTreet2 return (num + s1 + s2)
data Id a = Id a
instance Monad Id where 
  return = Id
  (>>=) (Id x) f = f x
sumTree :: Tree Int -> Id Int
num := n ;
s1 := sumTree t1 ;
s2 := sumTree t2 ;
return (num + s1 + s2) ;
