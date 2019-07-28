import Data.List (tails, nub, sort)

--Find all unique pairings in a list.

pairs xs = [(x, y) | x:ys) <- tails (nub xs), y <- ys]

main = print $ pairs [1, 2, 3, 3, 4]


