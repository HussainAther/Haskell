import Data.List (nub, elemIndices)
import qualified Data.Map as M
import Data.Map (Map, (!))
import Data.List (transpose)
import Text.CSV

--Decision tree.

type Class = String
type Feature = String
type Entropy = Double
type DataSet = [([String], Class)]

main = do
  rawCSV <- parseCSVFromFile "input.csv"
  either handleError doWork rawCSV
handleError = error "invalid file"

doWork csv = do
  let removeInvalids = filter (\x -> length x > 1)
  let myData = map(\x -> (init x, last x)) $ removeInvalids csv
  print $ dtree "root" myData

samples :: DataSet -> [[String]]
samples d = map fst d
classes :: DataSet -> [Class]
classes d = map snd d

entropy :: (Eq a) => [a] -> Entropy
entropy xs = sum $ map (\x -> prob x * info x) $ nub xs 
  where prob x = (length' (elemIndices x xs)) / (length' xs)
    info x = nega $ logBase 2 (prob x)
    length' xs = fromIntegral $ length xs

splitAttr :: [(Feature, Class)] -> Map Feature [Class]
splitAttr fc = foldl (\m (f,c) -> M.insertWith (++) f[c]m)
  M.empty fc

splitEntropy :: Map Feature [Class] -> M.Map Feature Entropy
splitEntropy m = M.map entropy m 
