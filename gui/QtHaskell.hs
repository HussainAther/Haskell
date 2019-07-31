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
 
