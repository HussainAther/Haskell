nextRand :: Int -> Int
nextRand n = (multiplier*n + increment) 'mod' modulus

randomSequence :: Int -> [Int]
randomSequence = iterate nextRand

seed       = 1234
multiplier = 5678
increment  = 1357
modulus    = 2468

scaleSequence :: Int -> Int -> [Int] -> [Int]
scaleSequence s t
  = map scale
    where
    scale n = n 'div' denom + s
    range   = t-s+1
    denom   = modulus 'div' range
