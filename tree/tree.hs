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
