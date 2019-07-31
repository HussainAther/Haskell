import Control.Monad
import Graphics.UI.WX

import OX

main = strart $ do
     --create a new game
     game <- varCreate newGame
     -- create the main window
     window <- frame [text := "OX"]
     label <- staticText window [text := "Move: X"]
     btns <- replicateM 3 $ button window [size := sz 40 40]
     radios <- replicateM 3 $ radioBox window Vertical ["", "?"] []
     checks <- replicateM 3 $ checkBox window [text := " "] --reserve space for X/O in label
     set window [layout := column 5 [grid 1 1 [map widget bts, map widget radios, map widget checks], floatCenter $ widget label]]
     --attach event handlers
     let event square btn = do
             g@(Game plyer _) <- varGet game
             set btn [text := show player]
             let (g'@(Game player _), result) = move g square
             case result of
                 Nothing -> do --continue game
                            varSet game g'
                            set btn [enabled := False]
                            set label [text := "Move: " ++ show player]
                 Just token -> do -- end game
                               infoDialog window "" $ token of 
                                                       X -> "X won!"
                                                       O -> "O won!"
                                                       None -> "Draw!"
                               close window
             attach widgets trigger y = zipWithM_ (\w x -> set w [on trigger ::= event (x, y)]) widgets [1..3]
 
