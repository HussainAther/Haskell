import Math.Statistics (pearson)
import Text.CSV
import Data.List (tails, nub, sort)

--Pearson coefficient.

calcSimilarities (Left error) = error "error parsing"
calcSimilarities (Right csv) = head $ reverse $ sort $ zip
  [ pearson (covertList a) (convertList) b)
  | (a, b) <- pairs csv]
  $ (pairs csv)

convertList :: [String] -> [Double]
convertList = map read
pairs xs = [(x, y) | (x:ys) <- tails (nub xs), y <- ys]

main = do 
  let fileName = "ratings.csv"
  input <- readFile filename
  let csv = parseCSV fileName input
  print $ calcSimilarities csv
