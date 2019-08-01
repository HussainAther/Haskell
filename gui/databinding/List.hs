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
