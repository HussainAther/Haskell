--Euler's method numerically approximates solutions of first-order ordinary differential equations (ODEs) with a given initial value.   
--It is an explicit method for solving initial value problems (IVPs), as described in the wikipedia page.

dsolveBy _ _ [] _ = error "empty solution interval"
dsolveBy method f mesh x0 = zip mesh results
  where results = scanl (method f) x0 intervals
        intervals = zip mesh (tail mesh)
