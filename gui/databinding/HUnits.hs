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

--- *** Test monadic functions ***
testSource :: Assertion
testSource = do --bind a source
                expected <- randomIO 
                source <- newVar expected :: IO (Source V A) 
                target <- randomIO >>= newVar :: IO (Source V A) 
                bind source id target writeVar 
                actual <- readVar target 
                assertEqual "Initial Bind" expected actual 
                --change its value 
                expected <- randomIO 
                writeVar source expected 
                actual <- readVar target 
                assertEqual "Value Changed" expected actual

-- | Generate a 'BindingList' for testing. 
list :: IO ([A], Int, BindingList V A) 
list = do (list, size) <- list' liftM (list, size,) (toBindingList list) 

-- | Assert that a 'BindingList' holds the expected list. 
assertList :: [A] -> BindingList V A -> Assertion 
assertList list bl = fromBindingList bl >>= (list @=?) 

-- | Assert that a 'BindingList' holds the expected list. 
assertPos :: Int -> BindingList V A -> Int -> Assertion 
assertPos expected bl reported = do pos <- position bl 
                                    assertEqual "Wrong positon" expected pos 
                                    assertEqual "Wrong positon reported" pos reported

testList :: Assertion 
testList = do (expected, _, bl) <- list 
              assertList expected bl 

testLength :: Assertion 
testLength = do (_, expected, bl) <- list 
                 B.length bl >>= (expected @=?) 

testSeek :: Assertion 
testSeek = do (list, size, bl) <- list 
              pos <- randomRIO (0,size-1) 
              seek bl pos >>= assertPos pos bl 
              actual <- readVar bl 
              list !! pos @=? actual
