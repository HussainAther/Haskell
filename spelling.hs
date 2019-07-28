import Data.Char (isAlpha, isSpace, toLower)
import Data.List (group, sort, maximumBy)
import Data.Ord (comparing)
import Data.Map (fromListWith, Map, Member, (!))

-- Fix spelling errors.

autofix :: Map String Int -> String -> String
autofix m sentence = unwords $ map (correct m) (words sentence)

getWords :: String -> [String]
getWords str = words $ filter (\x -> isAlpha || isSpace x) lower
where lower = map toLower str

train :: [String] -> Map String Int
train = fromListWith (+) . ('zip' repeat 1)
