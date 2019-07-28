import Text.CSV (parseCSV)

--Computing Euclidean (euclid) distances

main :: IO ()
main = do
  let fileName = "input.csv"
  input <- readFile fileName
  let csv = parseCSV fileName input
  let points = either (\e -> []) (map toPoint . myFilter) csv

