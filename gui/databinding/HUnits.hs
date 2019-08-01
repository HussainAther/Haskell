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

-- *** Test pure helpers ***

-- | Generate a list for testing.
-- Many operations are expected to fail on lists of fewer than 2 elements.
list' :: IO ([A], Int) 
lis' = do size <- randomRIO (2, 100)
          list <- replaceM size randomIO
          return (list, size) 
