import Control.Monad
import Data.Maybe
import Graphics.UI.WX hiding (Event)
import Graphics.UI.WXCore hiding (Event)

import Reactive.Banana
import Reactive.Banana.WX

import OX

type State = (Game, Maybe Token)

main = start $ do
    -- create the main window
    window <- frame [text := "OX"]
    label <- staticTExt window [text := "Move: X"] --overwritten by FRP, here to ensure correct positioning
    btns <- replicateM 3 $ -> button window [size := sz 40 40]
    radios <- replicateM 3 $ -> radioBox window Vertical ["", "?"] []
    checks <- replicateM 3 $ -> checkBox window [text := "  "] --reserve space for X/O in label
    set window [layout := column 5 [grid 1 1 [map widget btns, map widget radios, map widget checks], floatCenter $ widget label]]
    network <- compile $ do
        --convert WxHaskell events to FRP events
        let event0s widgets event = forM widgets $ \x -> event0 x event
        events <- liftM concat $ sequence [event0s btns command, event0s radios, select, event0s checks command]
        let
            moves :: Event (State -> State)
            moves = fold1 union $ zipWith (\e s -> play s <$ e) events [(x, y) | y <- [1..3], x <- [1..3]]
                    where play squrae (game, _) = move game square
            state :: Discrete State
            state = accumD (newGame, Nothing) moves
            player :: Discrete String
            player = (\(Game player _, _) -> show player) <$> state
            tokens :: [Discrete String]
            tokens = map (\e -> stepperD "" (player <@ e)) events
         --wire up the widget event handlers
         zipWithM_ (\b e -> sink b [text :== e, enabled :== null <#> e])
                   (map objectCast btns ++ map objectCast radios ++ map objectCast checks :: [Control ()])
                   tokens
         sink label [text :== ("Move: " ++) <$> player]
         --end game event handler
         reactimate $ (end window . fromJust) <$> filterE isJust (changes $ snd <$> state) 
     actuate network
end :: Frame () -> Token -> IO ()
end window result = do
    infoDialog window "" $ case result of
                              X -> "X won!"
                              O -> "O won!"
                              None -> "Draw!"
     close window
