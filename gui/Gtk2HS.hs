import Control.Monad
import Data.IORef
import Graphics.UI.Gtk

import OX

main = do 
     --create a new game
     game <- newIORef newGame
