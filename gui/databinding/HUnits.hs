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

testRemove' :: Assertion
testRemove' = do (list, size) <- list'
                  pos <- randomRIO (0, size-2)
                  let actual = remove' list pos
                  assertEqual "List hasn't shrunk correctly" (size-1) (P.length actual) 
                  assertEqual "Head of list incorrect" (take pos list) (take pos actual) 
                  assertEqual "Tail of list incorrect" (drop (pos+1) list) (drop pos actual)

testRemoveLast' :: Assertion
testRemoveLast' = do (list, size) <- list'
                     let actual = remove' list (size-1)
                     assertEqual "List hasn't shrunk correctly" (size-1) (P.length actual) 
                     assertEqual "List is incorrect" (take (size-1) list) actual

testInsert' :: Assertion
testInsert' = do (list, size) <- list'
                  pos <- randomRIO (0, size-1)
                  let actual = insert' list pos new
                  assertEqual "List hasn't shrunk correctly" (size+1) (P.length actual) 
                  assertEqual "Head of list incorrect" (take pos list) (take pos actual)
                  assertEqual "element not inserted" new (actual !! pos) 
                  assertEqual "Tail of list incorrect" (drop pos list) (drop (pos+1) actual)
