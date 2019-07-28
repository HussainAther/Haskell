import Data.List (sortBy, elemIndex, intercalate)
import Data.Ord (comparing)
import Text.Printf (printf)
import Data.Maybe (mapMaybe)
 
--Jaro Distance (Jaro-Winkler) distance jarowinkler 

jaro :: Ord a => [a] -> [a] -> Float
jaro x y =
  let f = (fromIntegral . length)
      [m, t] = [f, fromIntegral . transpositions] <*> [matches x y]
      [s1, s2] = [f] <*> [x, y]
  in case m of
       0 -> 0
       _ -> (1 / 3) * ((m / s1) + (m / s2) + ((m - t) / m))
 
matches :: Eq a => [a] -> [a] -> [(Int, a)]
matches s1 s2 =
  let [(l1, xs), (l2, ys)] =
        sortBy (comparing fst) ((length >>= (,)) <$> [s1, s2])
      r = quot l2 2 - 1
  in mapMaybe
       (\(c, n)
         -- Initial chars out of range ?
          ->
           let offset = max 0 (n - (r + 1))
               -- Any offset for this char within range.
           in elemIndex c (drop offset (take (n + r) ys)) >>=
              (\i -> Just (offset + i, c)))
       (zip xs [1 ..])
 
transpositions :: Ord a => [(Int, a)] -> Int
transpositions = length . filter (uncurry (>)) . (zip <*> tail)
