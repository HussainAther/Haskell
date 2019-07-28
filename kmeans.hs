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

relocate :: Map Point [Point] -> Map Point [Point]

relocate centroidsMap = 
  Map.foldWithKey insertCenter Map.empty centroidsMap
  where insertCenter _ ps m = Map.insert (center ps) ps m
    center [] = [0, 0]
    center ps = map average (transpose ps)
    average xs = sum xs / fromIntegral (length xs) 

kmeans :: [Point] -> [Point] -> [Point]
kmeans centroids points = 
if converged
then centroids
else kmeans (Map.keys newCentroidsMap) points
where convegrged = 
  all (< .00001) $ zipWith dist
   (sort centroids) (Map.keys newCentroidsMap)
  newCentroidsMap = relocate (assign centroids points)
  equal a b = dist a b < .00001
