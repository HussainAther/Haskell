parseValueLet2 :: CharParser (FiniteMap Char [Int]) Int
parseValueLet2 = choice
    [ int
    , do string "let "
         c <- letter
         char '='
         e <- parseValueLet2
         string " in "
         pushBinding c e
         v <- parseValueLet2
         popBinding c
         return v
    , do c <- letter
         fm <- getState
         case lookupFM fm c of
         Nothing -> unexpected ("variable " ++
                                show c ++
                                " unbound")
         Just (i:_) -> return i
    , between (char '(') (char ')') $ do
      e1 <- parseValueLet2
      op <- oneOf "+*"
      e2 <- parseValueLet2
      case op of
       '+' -> return (e1 + e2)
       '*' -> return (e1 * e2)
    ]
    where
      pushBinding c v = do
        fm <- getState
        case lookupFM fm c of
          Nothing -> setState (addToFM fm c [v])
          Just l -> setState (addToFM fm c (v:l))
     popBinding c = do
       fm <- getState
       case lookupFM fm c of
         Just [_] -> setState (delFromFM fm c)
         Just (_:l) -> setState (addToFM fm c l)
