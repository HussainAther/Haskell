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
