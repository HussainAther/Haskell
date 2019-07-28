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
