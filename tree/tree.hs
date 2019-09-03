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
