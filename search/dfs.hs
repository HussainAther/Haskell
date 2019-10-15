-- Depth-first search
depthSearch :: Ord a => Relation a -> a -> [a] -> [a]
depthFirst rel v = depthSearch rel v []
depthSearch rel v used
        = v : depthList rel (findDescs rel used' v) used'
