module OX (Square, Token(..), showBoard, Game(..), newGame, move) where

import Data.Array 
import Data.List

data Token = None | X | O 
  deriving Eq

- |The coordinates of a square. 
type Square = (Int,Int) 

-- |A noughts and crosses board. 
type Board = Array Square Token 

-- |Returns an empty 'Board'. 
newBoard :: Board 
newBoard = listArray ((1,1),(3,3)) (repeat None) 

-- |Puts a 'Token' in a 'Square'. 
setSquare :: Board -> Square -> Token -> Board 
setSquare board square token = 
  if (board ! square) /= None then error $ "square " ++ show square ++ " is not empty" 
  else board // [(square, token)]

-- |Determine if the 'Board' is in an end state. 
-- Returns 'Just' 'Token' if the game has been won, 'Just' 'None' for a draw, 
otherwise 'Nothing'. 
endGame :: Board -> Maybe Token 
endGame board 
  | Just X `elem` maybeWins = Just X  
  | Just O `elem` maybeWins = Just O 
  | None `notElem` elems board = Just None 
  | otherwise = Nothing 
  where rows :: [[Square]] 
    rows = let i = [1..3] 
      in [[(x,y) | y <- i] | x <- i] ++ -- rows 
         [[(y,x) | y <- i] | x <- i] ++ -- coloumns 
         [[(x,x) | x <- i], [(x,4-x) | x <- i]] -- diagonals
