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

adjustWeights :: Inputs -> Weights -> Expected -> Actual -> Weights
adjustWeights xs ws ex ax = add ws delta
  where delta = map (err * learningRate *) xs
    add = zipWith (+)
    err = ex - ac
    learningRate = 0.1
 
step :: Inputs -> Weights -> Expected -> Weights

step xs ws ex = adjustWeights xs ws ex (output xs ws t)
  where t = 0.2

epoch :: [(Inputs, Expected)] -> Weights -> (Weights, Delta)
epoch inputs ws = (newWeights, delta)
  where newWeights = foldl
    (\acc (xs, ex) -> step xs acc ex) ws input
    delta = (sum (absSub newWewights ws)) / length' ws
    absSub as bs map abs $ zipWith (-) as bs
    length' = fromIntegral . length
