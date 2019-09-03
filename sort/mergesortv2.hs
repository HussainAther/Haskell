mSort xs
  | (len < 2)   = xs
  | otherwise   = mer (mSort (take m xs)) (mSort (drop m xs))
    where 
    len = length xs
    m   = len 'div' 2

