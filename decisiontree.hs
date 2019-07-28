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

entropy 
