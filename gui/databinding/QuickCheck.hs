{-# LANGUAGE TupleSections, TemplateHaskell #-} 
import Test.QuickCheck 
import Test.QuickCheck.Modifiers 
import Test.QuickCheck.Monadic 
import Test.QuickCheck.All 
import Test.QuickCheck.Test 

import Control.Monad 
import Data.IORef 
import System.Exit 

import Binding.List as B 
import Prelude as P 

-- Change these to exercise different variable and data types 
type V = IORef 
type A = Char
