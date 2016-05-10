
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

fun proctype$foo {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = $extfcall (void, "printf", "x is %d", 3)
in
end


fun init$main (): void = let
  val x = 1 
in 
end





