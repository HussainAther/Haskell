{-# LANGUAGE ExistentialQuantification #-}
module Binding.Core (module Binding.Variable, Bindable, bind, Source) where

import Binding.Variable

-- | A data binding:
-- @a@ is the type of the data source
-- @a -> d@ is a function that extracts data from the source
-- @t2 is the binding target
-- @d -> t -> IO ()@ is a function that applies data to the target
data Binding a = forall d t. Binding (a -> d) t (t -> d -> IO ())
