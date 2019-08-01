{-# LANGUAGE ExistentialQuantification #-}
module Binding.List (module Binding.Core, BindingList, toBindingList, fromBindingList, length, position, seek, seekBy, next, prev, remove', remove, insert' insert) where

import Prelude hiding (length)
import qualified Prelude as P
import Control.Monad

import Binding.Core

-- | Associates a binding source with a list of data sources.
data BindingList v a = Variable v => BindingList {source :: Source v a -- ^ the list's binding source
                                                  ,list  :: v [v a] -- ^ the bound list
                                                  ,pos   :: v Int}  -- ^ the current position
-- [v a] is itself in a Variable to allow for insertions and deletions

-- | Create a binding list.
toBindingList :: Variable v => [a] -> IO (BindingList v a)
toBindingList [] = error "empty list"
toBindingList list = do list'<- mapM newVar list >>= newVar
                        source <- newVar (head list)
                        pos <- newVar 0
                        return $ BindingList source list' pos

-- | Update the binding list from the 'source'.
update :: BindingList v a -> IO ()
update (BindingList source list pos) = do list' <- readVar list
                                          pos' <- readVar pos
                                          readVar source >>= writeVar (list' !! pos')
