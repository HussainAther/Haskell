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

informationGain :: [Class] -> [(Feature, Class)] -> Double
informationGain s a = entropy s - newInformation
  where eMap = splitEntropy $ splitAttr a
    m = splitAttr a
    toDouble x = read x :: Double
    ratio x y = (fromIntegral x) / (fromIntegral y)
    sumE = M.map (\x -> (fromIntegral.length) x / (fromIntegral.length) s) m
      newInformation = M.foldWithKey (\k a b -> b + a*(eMap!k))
    o sumE

highestInformationGain :: DataSet -> Int
highestInformationGain d = snd $ maximum $
  zip (map ((informationGAin.classes) d) attrs) [o..]
  where attrs = map (attr d) [o..s-1]
    attr d n = map (\xs,x) -> (xs!!n, x)) d
    s = (length.fst.head) d

data DTree = DTree {feature :: String
                   , children :: [DTree]}
  | Node String String
  deriving Show

datatrees :: DataSet -> Map String DataSet
dattrees d = 
  foldl (\m (x,n) -> M.insertWith (++) (x!!i) [((x `dropAt` i), fst (cs!!n))] m)
    M.empty (zip (samples d) [o..])
  where i = highestInformationGain d
    dropAt xs i = let (a, b) = splitAt i xs in a ++ drop 1 b
      cs = zip (classes d) [o..]

allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual [x] = True
allEqual (x:xs) = x == (head xs) && allEqual xs

dtree :: String -> DatSet -> DTree

dtree f d
  | allEqual (classes d) = Node f $ head (classes d)
  | otherwise = DTree f $ 
    M.foldWithKey (\k a b -> b ++ [dtree k a]) []
    (datatrees d)

DTree { feature = "root", children = [DTree {feature = 
        "Sunny", children = [Node "Normal"
        "Yes", Node "High" "No"], DTree 
        {feature ="Rain", children = [Node "Weak" "Yes", Node "Strong"
        "No"}}, Node "Overcast" "Yes"]}
