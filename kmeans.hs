import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (minimumBy, sort, transpose)
import Data.Ord (comparing)

--K-means (kmeans k means) clustering.

type Point = [Double]
dist :: Point -> Point -> Double
dist a b = sqrt $ sum $ map (^2) $ zipWith (-) a b

assign :: [Point] -> [Point] -> Map Point [Point]

assign centroids points = 
  Map.fromListWith (++) [(assignPoint p, [p]) | p <- points]
  where assignPoint p = minimumBy (comparing (dist p)) centroids
