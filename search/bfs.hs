--Breadth-first search
breadthFirst :: Ord a => Relation a -> a -> [a]
breadthFirst rel val
= limit step start
  where
  start = [val]
  step xs = xs ++ nub (concat (map (findDescs rel xs) xs))
