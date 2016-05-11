
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun proctype$foo {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = $extfcall (void, "printf", "v1 is %d", v1)
in
end

fun proctype$foo1 {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = $extfcall (void, "printf", "v1 is %d", v1)
in
end

fun pml$init (): void = let
  val x = 1 
  val y = pml$run (lam () => proctype$foo (1, x))
  val _ = pml$run (lam () => proctype$foo1 (1, y))
in 
end





