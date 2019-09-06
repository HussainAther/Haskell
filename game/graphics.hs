import Graphics.Gloss.Rendering
import Graphics.Gloss.Data.Color
import Graphics.Gloss.Data.Picture

main :: IO ()
main = do
   let width  = 640
       height = 480
   withWindow width height "Resurrection" $ \win -> do

  renderFrame window glossState = do
     displayPicture (width, height) white glossState 1.0 $
