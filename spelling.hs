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

edits 1 :: String -> [String]

edits1 word = unique $ deletes ++ transposes ++ replaces ++ inserts

where splits = [(take i word', drop i word')
  |i <- [o..length word']]

deletes = [a ++ (trail b)
  | (a, b) <- splits
  , (not.null) b ]
 
transposes = [a ++ [b !! 1] ++ [head b] ++ (drop 2 b)
  | (a, b) <- splits, length b > 1]

replaces = [a ++ [c] ++ (drop 1 b)
  | (a, b) <- splits, c <- alphabet
  , (not.null) b ]

inserts = [a ++ [c] ++ b |
  (a, b) <- splits, c <- alphabet]

alphabet = ['a'..'z']

word' = map toLower word

knownEdits2 :: String -> Map String a -> [String]
knownEdits2 word m = unique $ [ e2
  | e1 <- edits1 word
  , e2 <- edits2 e1
  , e2 'member' m]

unique :: [String] -> [String]
unqiue = map head.group.sort

known :: [String] -> Map String a -> [String]
known ws m = filter ('member' m) ws

correct :: Map String Int -> String -> String

correct m word maximumBy (comparing (m!)) candidates
  where candidates = head $ filter (not.null)
    [ known [word] m 
    , known (edits1 word) m
    , knownEdits2 word m 
    , [word] ]

main :: IO ()

main = do
  rawText <- readfile "big.txt"
  let m = train $ getWords rawText
  let sentence = "this is the codez"
  print $ autofix m sentence 
