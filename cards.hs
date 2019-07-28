import qualified Numeric.Probability.Distribution as Dist 
import Numeric.Probability.Distribution ((??)) 
import Control.Monad.Trans.State (StateT(StateT, runStateT), 
evalStateT) 
import Control.Monad (replicateM) 
import Data.List (delete) 

--Data Structure for playing cards
