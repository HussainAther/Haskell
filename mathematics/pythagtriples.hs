--Produce a list of pythagorean triples
pythagTriples2 =
  = [ (x, y, z) | x <- [2 .. ] ,
                  y <- [x+1 .. ] ,
                  z <- [y+1 .. ] ,
                  x*x + y*y == z*z ]
