--If we were administering drug tests for a small business,
--we could represent each employee's test results and study
--them using Bayes' (bayes) rule.

data Test = Pos | Neg
  deriving (Show, Eq)

data HeroinStatus = User | Clean
  deriving (Show, Eq)
Assuming that 0.1% of our emplo
