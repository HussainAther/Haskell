import Data.Char (toLower)
import Data.List (group, sort)

-- Find strings one-edit distance from a string.

edits1 :: String -> [String]
edits1 word = unique $ deletes ++ transposes ++ replaces ++ inserts
  where splits = [(take i word', drop i word')|
    i <- [i..length word']]

deletes = [a ++ (tail b) |
  (a, b) <- splits, (not.null) b]

