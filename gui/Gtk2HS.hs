import Control.Monad
import Data.IORef
import Graphics.UI.Gtk

import OX

main = do 
     --create a new game
     game <- newIORef newGame
     
     --create the main window
     initGUI
     window <- windowNew
     set window [windowTitle := "OX"]
     onDestroy window mainQuit
     vbox <- vboxNew False 0
     set window [containerChild := vbox]
     label <- labelNew $ Just "Move: X"
     boxPackEndDefaults vbox label
     table <- tableNew 3 3 True
     boxPackEndDefaults vbox table
     btns <- replicateM 3 toggleButtonNew
     radios <- replicateM 3 $ do
       group <- vBoxNew False 0
       button <- radioButtonNewWithLabel "" -- radioButtonNew doesn't line up with radioButtonWithLabel
       button `on` toggled $ set button [widgetSensitive := False]
       button_ <- radioButtonNewWithLabel "?"
       set button_ [radioButtonGroup := button]
       mapM_ (boxPackStartDefaults group) [button, button_]
     checks <- replicateM 3 checkButtonNew
     --attach event handlers
