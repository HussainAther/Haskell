import Data.List (mapAccumL)

-- Feigenbaum constants

feigenbaumApprox :: Int -> [Double]
feigenbaumApprox mx = snd $ mitch mx 10
  where
    mitch :: Int -> Int -> ((Double, Double, Double), [Double])
    mitch mx mxj =
      mapAccumL
        (\(a1, a2, d1) i ->
            let a =
                  iterate
                    (\a ->
                        let (x, y) =
                              iterate
                                (\(x, y) -> (a - (x * x), 1.0 - ((2.0 * x) * y)))
