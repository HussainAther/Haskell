-- | Mutable variables in the IO Monad
module Binding.Variable where

import Data.IORef
import Control.Concurrent.MVar
import Control.Concurrent.STM

class Variable v where
   -- | Create a new variable.
   newVar     :: a -> IO (v a)
   -- | Read a variable.
   readVar    :: v a -> IO a
   -- | Write a variable.
   writeVar   :: v a -> a -> IO ()
   -- | Modify a variable.
   modifyVar  :: v a -> (a -> a) -> IO ()
   -- | Modify a variable, and return some value.
   modifyVar' :: v a -> (a -> (a, b)) -> IO b

