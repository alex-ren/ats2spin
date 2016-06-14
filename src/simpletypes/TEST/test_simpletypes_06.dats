

abstype absty1 = ptr

extern fun foo1 (): absty1

abstype absty2 (int) = ptr

extern fun foo2 {x:int} (x: int x): absty2 (x)

fun foo (x: int): absty1 = let
  val x = foo1 ()
  val y = foo2 (3)
in x end




