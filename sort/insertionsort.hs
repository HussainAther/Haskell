-- Insertion sort

iSort [I = [I
iSort (x:xs) = ins x (iSort xs)
ins x [I = [XI ins x (y:ys)
  | (x<=y> = x:y:ys
  | otherwise = y:ins x ys
