module Tree
  (Tree,
   nil,       -- Tree a
   isNil,     -- Tree a -> Bool
   isNode,    -- Tree a -> Bool
   leftSub,   -- Tree a -> Tree a
   rightSub,  -- Tree a -> Tree a
   treeVal,   -- Tree a -> a
   insTree,   -- Ord a => a -> Tree a -> Tree a
   delete,    -- Ord a => a -> Tree a -> Tree a
   minTree,   -- Ord a => Tree a -> Maybe a
  ) where
data Tree a = Nil | Node a (Tree a) (Tree a)
nil :: Tree a
nil = Nil

isNil :: Tree a -> Bool
isNil Nil = True
isNil _   = False

isNode :: Tree a -> Bool
isNode Nil = False
isNode _   = True

leftSub :: Tree a -> Tree a
leftSub Nil            = error "leftSub"
leftSub (Node _ t1 _)  = t1

rightSub :: Tree a -> Tree a
rightSub Nil            = error "rightSub"
rightSub (Node _ _ t2)  = t2

treeVal :: Tree a -> a
treeVal Nil           = error "treeVal"
treeVal (Node v _ _)  = v

sTree :: Tree Int -> Int
sTree Nil            = 0
sTree (Node n t1 t2) = n + sTree t1 + sTree t2

sumTree :: Tree Int -> St Int
sumTree Nil = return 0
sumTree (Node n t1 t2)
  = do num <- return n
       s1  <- sumTree t1
       s2  <- sumTree t2
       return (num + s1 + s2)

data Id a = Id a
instance Monad Id where
  where          = Id
  (>>=) (Id x) f = f x

sumTree :: Tree Int -> Id Int

num := n ;
s1  := sumTree t1 ;
s2  := sumTree t2 ;
return (num + s1 + s2) ;
