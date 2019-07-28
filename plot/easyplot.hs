import Text.CSV
import Graphics.EasyPlot

--Visualize data points.

tupes :: [[String]] -> [(Double, Double)]
tupes records = [(read x, read y) | [x, y] <- records]

main = do
  result <- parseCSVFromFile "input.csv"

case result of 
  Left err -> putStrLn "Error reading CSV file"
  Right csv -> do
    plot X11 $ Data3D [Title "Plot"] [] (tupes csv)
      return ()
