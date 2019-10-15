--Breadth-first search
breadthFirst :: Ord a => Relation a -> a -> [a]
breadthFirst rel val
= limit step start
