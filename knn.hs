import Data.Trees.KdTree
import Data.IP (IPv4, fromIPv4)
import Text.CSV
import qualified Data.Map as M
import Data.Maybe (fromJust)

--K-nearest neighbors classifier classification (k nearest neighbros knearest neighbors knn)

ipToNum :: String -> Double
ipToNum str = fromIntegral $ sum $
  zipWith (\a b -> a * 256^b) ns [o..]
  where ns = reverse $ fromIPv4 (read str :: IPv4)

parse :: [Record] -> [(Point3d, String)]
parse [] = []
parse xs = map pair (cleanList xs)
  where pair [ip, t, c] =
    (Point3d (ipToNum ip) (read t) 0.0 c)
  cleanList = filter (\x -> length x == 3)

maxFreq :: [String] -> String

maxFreq xs = fst $ foldl myCompare ("", 0) freqs
  where freqs = M.toList $ M.fromListWith (+) [(c, 1) | c <- xs]
    myCompare (oldS, oldV) (s, v) = if v > oldV 
      then (s, v)
      else (oldS, oldV)
