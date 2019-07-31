{-# LANGUAGE RankNTypes, ScopedTypeVariables, EmptyDataDecls #-}

import Control.Monad 
import Data.IORef 
import Qtc.Classes.Qccs hiding (event) 
import Qtc.Classes.Gui hiding (end,move,button) 
import Qtc.ClassTypes.Gui 
import Qtc.Core.Base 
import Qtc.Gui.Base 
import Qtc.Gui.QApplication 
import Qtc.Gui.QWidget 
import Qtc.Gui.QPushButton 
import Qtc.Gui.QCheckBox 
import Qtc.Gui.QRadioButton 
import Qtc.Gui.QDialog 
import Qtc.Gui.QGroupBox 
import Qtc.Gui.QAbstractButton () 
import Qtc.Gui.QMessageBox 
import Qtc.Gui.QLabel 
import Qtc.Gui.QVBoxLayout 
import Qtc.Gui.QBoxLayout () 
import Qtc.Gui.QGridLayout 

import OX

type WidgetCreator = (forall a. QAbstractButton a -> IO ()) -> IO (QWidget ())

-- |Create a button.
data COxQPushButton
type OxPushButton = QPushButtonSc COxQPushButton

oxPushButton :: IO OxPushButton
oxPushButton = qSubClass $ qPushBUtton " "

button :: WidgetCreator
button e = do
    button <- oxPushButton
    setMaximumSize button (40::Int, 40::Int)
    connectSlot button "clicked()" button "click()" e
    qCast_QWidget button

-- |Create a radio button group.
data COxQRadioButton
type OxRadioButton = QRadioButtonSc COxQRadioButton

oxRadioButton :: String -> IO OxRadioButton
oxRadioButton e = do
   group <- qGroupBox ()
   layout <- qVBoxLayout ()
   setLayout group layout
   button <- oxRadioButton ""
   setChecked button True
   connectSlot button "clicked()" button "click()" $ \button -> setEnabled (button::OxRadioButton) False 
   button_ <- oxRadioButton "?"
   connectSlot button_ "clicked()" button_ "click()" e
   mapM_ (addWidget layout) [button, button_]
   qCast_QWidget group

-- |Create a check box.
data COxQCheckBox
type OxCheckBox = QCheckBoxSC COxQCheckBox

oxCheckBox :: IO OxCheckBox
oxCheckBox = qSubClass $ qCheckBox " "

check :: WidgetCreator
check e = do
    check <- oxCheckBox
    connectSlot check "clicked()" check "click()" e
    qCast_QWidget check

main = do
   --create a new game
   game <- newIORef newGame
   
   --create the main window
   qApplication ()
   window <- qDialog ()
   setWindowTitle window "OX"
   vbox <- qVBoxLayout ()
   setLayout window vbox
   grid <- qGridLayout ()
   addLayout vbox grid
   label <- qLabel "Move: X"
   addWidget vbox label
   --attach event handlers
   let event square button = do
           g@(Game player _) <- readIORef game
           setText button $ show player
           let (g'@(Game player _), result) = move g square 
           case result of
               Nothing -> do --continue game
                          writeIORef game g'
                          setEnabled button False
                          setText label $ "Move: " ++ show player
               Just token -> do --end game
                             box <- qMessageBox window
                             setText box $ case token of
                                               X -> "X won!"
                                               O -> "O won!"
                                               None -> "Draw!"
                             qshow box ()
   --widgetCreator will return a widget with an event attached
   --widgets creates 3 of them in a row
   widgets (widgetCreator::WidgetCreator) y = forM_ [1..3] $\x -> do
                                  w <- widgetCreator $ event (x, y)
                                  addWidget grid (w, y-1, x-1)

zipWithM_ widgets [button, radioGroup, check] [1..3]
qshow window ()
qApplicationExec ()
