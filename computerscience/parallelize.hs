import Control.Parallel.Strategies (runEval, rpar)

--Parallelize procedures by running them in parallel.

main = do
  print $ runEval do
    a <- rpar task1
    b <- rpar task2
    return (a, b)

