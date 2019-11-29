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
