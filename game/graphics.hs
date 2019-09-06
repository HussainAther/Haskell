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
               line [(-30, -30), (-40, 30), (30, 40), (50, -20)]
         , Color (makeColor 0 128 255 1) $ translate (-100) 100 $
               lineLoop [(-30, -30), (-40, 30), (30, 40), (50, -20)]
         , Color red $ translate 0 100 $
               circle 30
         , Color green $ translate 100 100 $
               thickCircle 30 10
         , Color yellow $ translate 200 100 $
               circleSolid 30
