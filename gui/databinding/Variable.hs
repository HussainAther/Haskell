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

