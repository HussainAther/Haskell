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
