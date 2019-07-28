import Text.CSV
import Graphics.EasyPlot

--Visualize data points.

tupes :: [[String]] -> [(Double, Double)]
tupes records = [(read x, read y) | [x, y] <- records]

main = do
  result <- parseCSVFromFile "input.csv"
