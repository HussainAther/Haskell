{- # LANGUAGE ScopedTypeVariables #-}
import Control.Exception
import OX

play :: Game -> IO ()
play game = do
            putChar '\n'
            print game
            input <- getLine
            let (game'@(Game _ board), result) = move game $ read $ '(' : input ++ ")"
            attempt <- try $ evaluate result
            case attempt of
              Left (error::ErrorCall) -> print error >> play game
              Right result -> case result of 
                              Nothing -> play game'
                              Just token -> print putStrLn $ "\n" ++ showBoard
board ++ "\n" ++ if token == None then "Draw" else show token ++ " won!"
main = play newGame
