infixr 5 >*>

type Parse a b = [a] -> [(b, [a])

none :: Parse a b
none inp = []

succeed :: b -> Parse a b
succeed val inp = [(val, inp)]
