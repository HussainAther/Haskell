import Data.List (mapAccumL)

-- Feigenbaum constants

feigenbaumApprox :: Int -> [Double]
feigenbaumApprox mx = snd $ mitch mx 10
  where
    mitch :: Int -> Int -> ((Double, Double, Double), [Double])
