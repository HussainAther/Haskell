mSort xs
  | (len < 2)   = xs
  | otherwise   = mer (mSort (take m xs)) (mSort (drop m xs))
    where 
    len = length xs
    m   = len 'div' 2

mer (x:xs) (y:ys)
  | (x<=y)      = x : mer xs (y:ys)
  | otherwise   = y : mer (x:xs) ys

