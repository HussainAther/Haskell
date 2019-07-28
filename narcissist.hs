--A narcissist reads a string of symbols from its input, and produces no output except a "1" or "accept" if that string matches its own source code, or a "0" or "reject" if it does not.
main = let fi t e c = if c then t else e in do ct <- getContents; putStrLn $ fi ['a','c','c','e','p','t'] ['r','e','j','e','c','t'] $ take (length ct - 1) ct == let q s = (s ++ show s) in q "main = let fi t e c = if c then t else e in do ct <- getContents; putStrLn $ fi ['a','c','c','e','p','t'] ['r','e','j','e','c','t'] $ take (length ct - 1) ct == let q s = (s ++ show s) in q "

