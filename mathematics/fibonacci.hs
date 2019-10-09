fibP :: Int -> (Int,Int) 
fibP 0 = (0,l)
fibP n = (y,x+y)
         where
         (x,y)= fibP (n-1)
