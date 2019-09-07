data Expr = Lit Int | Var Var | Op Ops Expr Expr
data Ops  = Add | Sub | Mul | Div | Mod
type Var  = Char
initial :: Store
value   :: Store -> Var -> Int
update  :: Store -> Var -> Int -> Store
