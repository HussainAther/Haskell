import Data.Char (toLower)
import Data.List (group, sort)

-- Find strings one-edit distance from a string.

edits1 :: String -> [String]
edits1 word = unique $ deletes ++ transposes ++ replaces ++ inserts
  where splits = [(take i word', drop i word')|
    i <- [i..length word']]

deletes = [a ++ (tail b) |
  (a, b) <- splits, (not.null) b]

transposes = [a ++ [b!!1] ++ [head b] ++ (drop 2 b) |
  (a, b) <- splits, length b > 1]

replaces = [a ++ [c] ++ (drop 1 b)
  | (a, b) <- splits
  , c <- alphabet
  , (not.null) b ]

inserts = [a ++ [c] ++ b
  | (a, b) <- splits 
  ,c <- alphabet ]

alphabet = ['a'..'z']
word' = maptoLower word
unique :: [String] -> [String]
unique = map head.group.sort
main = print $ edits1 "hi"
