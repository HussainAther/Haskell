nextRand :: Int -> Int
nextRand n = (multiplier*n + increment) 'mod' modulus

randomSequence :: Int -> [Int]
randomSequence = iterate nextRand
