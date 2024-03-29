-- If we were administering drug tests for a small business,
-- we could represent each employee's test results and study
-- them using Bayes' (bayes) rule.

data Test = Pos | Neg
  deriving (Show, Eq)

data HeroinStatus = User | Clean
  deriving (Show, Eq)
-- If .1% of employees have recently used heroin and the test
-- is 99% accurate, we can model the test.
drugTest1 :: Dist d => d (HeroinStatus, Test)
drugTest1 = do
  heroinStatus <- percentUser 0.1
  testResult <-
    if heroinStatus == User
      then percentPos 99
      else percentPos 1
  return (heroinStatus, testResult)

-- Some handy distributions.
percentUser p = percent p User Clean
percentPos p = percent p Pos Neg

-- A weighted distribution with two elements.
percent p x1 x2 =
  weighted [(x1, p), (x2, 100-p)]

-- Run the drug test.
exact drugTest1

-- Ignore negative test results.
drugTest2 :: Dist d => d (Maybe HeroinStatus)
drugTest2 = do
  (heroinStatus, testResult) <- drugTest1
  return (if testResult == Pos
            then Just heroinStatus
            else Nothing)

exact drugTest2

value (Perhaps x _) = x
prob (Perhaps _ p) = p

catMaybes' :: [Perhaps (Maybe a)] -> [Perhaps a]
catMaybes' [] = []
catMaybes' (Perhaps Nothing _ : xs) =
  catMaybes' xs
catMaybes' (Perhaps (Just x) p : xs) =
  Perhaps x p : catMaybes' xs

onlyJust :: FDist (Maybe a) -> FDist a
onlyJust dist
    | total > 0 = PerhapsT (map adjust filtered)
    | otherwise = PerhapsT []
  where filtered = catMaybes' (runPerhapsT dist)
        total = sum (map prob filtered)
        adjust (Perhaps x p) =
          Perhaps x (p / total)

type FDist' = MaybeT FDist

-- Monads are Functors, no matter what
-- Haskell thinks.
instance Functor FDist' where
  fmap = liftM

instance Dist FDist' where
  weighted xws = lift (weighted xws)

bayes :: FDist' a -> [Perhaps a]
bayes = exact . onlyJust . runMaybeT

condition :: Bool -> FDist' ()
condition = MaybeT . return . toMaybe
  where toMaybe True  = Just ()
        toMaybe False = Nothing

drugTest3 :: FDist' HeroinStatus ->
             FDist' HeroinStatus
drugTest3 prior = do
  heroinStatus <- prior
  testResult <-
    if heroinStatus == User
      then percentPos 99
      else percentPos 1
  -- As easy as an 'if' statement:
  condition (testResult == Pos)
  return heroinStatus

bayes (drugTest3 (percentUser 50))
