--If we were administering drug tests for a small business,
--we could represent each employee's test results and study
--them using Bayes' (bayes) rule.

data Test = Pos | Neg
  deriving (Show, Eq)

data HeroinStatus = User | Clean
  deriving (Show, Eq)
--If .1% of employees have recently used heroin and the test
--is 99% accurate, we can model the test.
drugTest1 :: Dist d => d (HeroinStatus, Test)
drugTest1 = do
  heroinStatus <- percentUser 0.1
  testResult <-
    if heroinStatus == User
      then percentPos 99
      else percentPos 1
  return (heroinStatus, testResult)

