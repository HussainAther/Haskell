import Data.List (nub, elemIndices)
import qualified Data.Map as M
import Data.Map (Map, (!))
import Data.List (transpose)
import Text.CSV

--Decision tree.

type Class = String
type Feature = String
type Entropy = Double
type DataSet = [([String], Class)]
