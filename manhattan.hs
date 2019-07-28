import Text.CSV (parseCSV)

--Calculate Manhattan distance.

main :: IO ()
main = do
  let fileName = "input.csv"
  input <- readFile fileName
  let csv = parseCSV fileName input

