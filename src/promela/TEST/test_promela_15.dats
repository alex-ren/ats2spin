

/*
* This file is for testing the usage of call by reference and
* recursive function.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (n: int, x: &int): void =
if n > 0 then let
  val () = x := n * x
in
  inline$foo (n - 1, x)
end

fun pml$init (): void = let
  var x:int = 1
  val () = $extfcall (void, "printf", "old x is %d\\n", x)
  val ()  = inline$foo (4, x)
  val () = $extfcall (void, "printf", "new x is %d\\n", x)
in 
end


