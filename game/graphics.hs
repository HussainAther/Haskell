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
       Pictures
         [ Color violet $ translate (-200) 100 $ 
               polygon [((-10), 10), ((-10), 70), (20, 20), (20, 30)]
         , Color red $ translate (-200) 100 $
