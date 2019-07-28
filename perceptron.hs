import Control.Monad (replicateM)
import System.Random (randomR, getStdRandom)

--Neural network perceptron.

type Inputs = [Float]
type Weights = [Float]
type Threshold = Float
type Output = Float
type Expected = Float
type Actual = Float
type Delta = Float
type Interval = Int
type Step = (Weights, Interval)

output :: Inputs -> Weights -> Threshold -> Output
output xs ws t
  | (dot xs ws) > t = 1
  | otherwise = 0
  where dot as bs sum $ zipWith (*) as bs
