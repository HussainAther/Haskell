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

-- *** Helpers to generate random lists and positions *** 
-- | A random list with at least two elements. 
newtype List = List [A] deriving Show 

instance Arbitrary List where 
   arbitrary = liftM List $ choose (2, 100) >>= vector 
   shrink (List xs) = [List ys | ys <- shrink xs, P.length ys > 1] 

-- | Maps @i@ to a position in @xs@. 
anywhere :: Int -> [A] -> Int 
anywhere i xs = let max = P.length xs - 1 
                in if max == 0 then 0 else i `mod` max 

-- | Anywhere in the list except the last element. 
notLast :: Int -> [A] -> Int 
notLast i = anywhere i . tail

-- | Create a 'BindingList', and 'seek' to @pos@. 
list :: [A] -> Int -> IO (BindingList V A) 
list xs pos = do bl <- toBindingList xs 
                 seek bl pos 
                 return bl

-- *** Test pure functions *** 
prop_remove' :: [A] -> Int -> Bool 
prop_remove' xs i = let pos = anywhere i xs 
                        actual = remove' xs pos 
                    in P.length actual == P.length xs - 1 
                    && take pos actual == take pos xs              
                    && drop (pos+1) xs == drop pos actual 

prop_removeLast' :: [A] -> Bool 
prop_removeLast' xs = let pos = P.length xs - 1 
                          actual = remove' xs pos 
                      in P.length actual == pos 
                      && actual == take pos xs

prop_insert' :: [A] -> Int -> A -> Bool 
prop_insert' xs i x = let pos = anywhere i xs 
                          actual = insert' xs pos x 
                      in P.length actual == P.length xs + 1 
                      && take pos actual == take pos xs 
                      && actual !! pos == x 
                      && drop pos actual == drop (pos+1) xs -- *** QuickCheck 'Property's for Monadic actions. ***
