import Data.Map (Map, (!), delete)
import qualified Data.Map as Map
import Data.Ord (comparing)
import Data.List (sort, tails, transpose, minumumBy)

--Hierarchical clustering

type Point = [Double]
center :: [Point] -> Point
center points = map average (transpose points)
  where xs = sum xs / fromIntegral (length xs)

merge :: Map Point [Point] -> Map Point [Point]
merge m = Map.insert (center [a, b]) ((m ! a) ++ (m ! b)) newM

where (a, b) = nearest (MAp.keys m)
