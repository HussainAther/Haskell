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
     let event square button = button `on` toggled $ do
             g@(Game player _) <- readIORef game
             set button [buttonLabel := show player]
             let (g'@(Game player _), result) = move g square
             case result of
               Nothing -> do --continue game
                          writeIORef game g'
                          set button [widgetSensitive := False]
                          set label [labelLabel := "Move: " ++ show player]
               Just token -> do --end game
                             let message = case token of 
                                                X -> "X won!"
                                                O -> "O won!"
                                                None -> "Draw!"
                             messageDialogNew Nothing [] MessageInfo ButtonsOk message >>= dialogRun
                             widgetDestroy window
     zipWithM_ (\b x -> event (x, 1) b >> tableAttachDefaults table b (x-1) x 0 1) btns [1..3]
     zipWithM_ (\(t,g) x -> event (x,2) r >> tableAttachDefaults table g (x-1) x 1 2) radios [1..3]
     zipWithM_ (\c x -> event (x,3) c >> tableAttachDefaults table c (x-1) x 2 3) checks [1..3]
     --run the UI
     widgetShowAll window
     mainGUI 
      
