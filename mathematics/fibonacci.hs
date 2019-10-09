fibs ::[Int]
fibs = 0 : 1 : zipwith (+) fibs (tail fibs)
