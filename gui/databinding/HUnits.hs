{-# LANGUAGE TupleSections #-}
import Test.HUnit

import Control.Monad
import Data.IORef
import System.Exit
import System.Random

import Binding.List as B
import Prelude as P

-- Change these to exercise different variable and data types
type V = IORef
type A = Int 
