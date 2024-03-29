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

instance Variable IORef where
   newVar = newIORef
   readVar = readIORef
   writeVar = writeIORef
   modifyVar = modifyIORef
   modifyVar' = atomicModifyIORef

instance Variable MVar where
   newvar = newMVar
   readVar = takeMVar
   writeVar = putMVar
   modifyVar v f = modifyMVar_ v (return . f) 
   modifyVar' v f = modifyMVar v (return . f) 

instance Variable TVar where
   newVar = newTVarIO
   readVar = readTVarIO
   writeVar v x = atomically $ writeTVar v x
   modifyVar v f = atomically $ do x <- readTVat v writeTVar v (f x)

instance Variable TMVar where
   newVar = newTMVarIO
   readVar v = atomicalyl $ takeTMVar v
   writeVar v x = atomically $ putTMVar v x
   modifyVar v f = atomically $ do x <- takeTMVar v putTMVar v (f x)
   modifyVar' v f = atomically $ do x <- takeTMVar v putTMVar v 
                                     let (x', y) = f x 
                                     putTMVar v x' 
                                     reutrn y
       
