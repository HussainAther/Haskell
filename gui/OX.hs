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
