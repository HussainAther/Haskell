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
    rows2tokens :: [[Token]] 
    rows2tokens = map (map (board !)) rows
    isWin :: [Token] -> Maybe Token 
    isWin tokens 
      | all (==X) tokens = Just X 
      | all (==O) tokens = Just O 
      | otherwise = Nothing
    maybeWins :: [Maybe Token]i
    maybeWins = map isWin rows2tokens

-- |The state of a game, i.e. the player who's turn it is, and the current board. data Game = Game Token Board

newGame :: Game
newGame = Game X newBoard

-- |Puts the player's token on the specified square.
-- Returns "Just" "Token" if the game has been won, "Just" "None" for a draw.
otherwise "Nothing".
move :: Game -> Square -> (Game, Maybe Token)
move (Game player board) square = 
  let board' = setSquare board square player
    player' = case player of {X -> O; O -> X}
  in (Game player' board', endGame board')

-- Show instances

outersperse :: a -> [a] -> [a]
outersperse x ys = x : intersperse x ys ++ [x]

instance Show Token where
  show X = "X"
  show O = "O"
  show None = " "
  showList tokens = showString $ outersperse '|' $ concatMap show tokens

-- Board cannot be declared an instance of Show, as this would overlap with the existing instance for Array
showBoard :: Board -> String
showBoard board = 
  let border = " +-+-+"
    i = [1..3]
    showRow x = show x ++ show [board ! (y, x0 | y <- i]
  in intercalate "\n" $ "  1 2 3" : outersperse border (map showRow i)

instance Show Game where
  show (Game player board) = showBoard board ++ "\n\nTurn: " ++ show player
