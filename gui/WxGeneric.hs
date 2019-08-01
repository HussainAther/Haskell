{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TemplateHaskell, UndecidableInstances #-}
import Graphics.UI.WX
import Graphics.UI.WxGeneric
import Graphics.UI.SybWidget.MySYB

data Name = Name {forename :: String, surname :: String} deriving Show
data Student = Student {name :: Name, tutor :: Name, id :: Int} deriving Show

anonymous = Name "" ""
student = Student anonymous anonymous 0

$(derive [''Name, ''Student])
instance WxGen Name
instance WxGen Student

main = start $ do
    window <- frame [text := "WxGeneric"]
    editor <- genericWidget window student
    set window [layout := widget editor]
    return windo
