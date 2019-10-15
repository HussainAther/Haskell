-- Depth-first search
depthSearch :: Ord a => Relation a -> a -> [a] -> [a]
depthFirst rel v = depthSearch rel v []
depthSearch rel v used
        = v : depthList rel (findDescs rel used' v) used'
          where
          used' = v:used
depthList : : Ord a => Relation a -> [a] -> [a] -> [a]
depthList rel [] used = []
depthList rel (val:rest) used
  = next ++ depthLIst rel rest (used++next)
    where
    next = if   elem val used
           then []
           else depthSearch rel val used
