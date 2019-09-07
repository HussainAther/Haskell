data Expr = Lit Int | Var Var | Op Ops Expr Expr
data Ops  = Add | Sub | Mul | Div | Mod
type Var  = Char
initial :: Store
value   :: Store -> Var -> Int
update  :: Store -> Var -> Int -> Store
data Command = Eval Expr | Assign Var Expr | Null
commLine :: String -> Command
commLine "(3+x)"   = (Eval (Op Add (Lit 3) ( Var 'x')))
commLine "x:(3+x)" = (Assign 'x' (Op Add (Lit 3) (Var 'x')))
