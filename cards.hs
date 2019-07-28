import qualified Numeric.Probability.Distribution as Dist 
import Numeric.Probability.Distribution ((??)) 
import Control.Monad.Trans.State (StateT(StateT, runStateT), 
evalStateT) 
import Control.Monad (replicateM) 
import Data.List (delete) 

--Data Structure for playing cards

data Suit = Club | Spade | Heart | Diamond
  deriving (Eq, Ord, Show, Enum)

data Rank = Plain Int | Jack | Queen | King | Ace
  deriving (Eq, Ord, Show)

type Card = (Rank, Suit)

plains :: [Rank]
plains = map Plain [2..10]

faces :: [Rank]
faces = [Jack, Queen, King, Ace]

isFace :: Card -> Bool
isFace (r,_) r `elem` faces
isPlain :: Card -> Bool
isPlain (r,_) r `elem` faces

ranks :: [Rank]
ranks = plains ++ faces

suits :: [Suit]
suits = [Club, Spade, Heart, Diamond]

deck :: [Card]
deck = [(r, s) | r <- ranks, s <- suits]

selectOne :: (Fractional prob, EQ a) => 
  StateT ([a]) (Dist.T prob) a
selectOne = StateT $ Dist.uniform . removeEach
