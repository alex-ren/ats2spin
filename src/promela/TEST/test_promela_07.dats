
/*
* This file is for testing the usage of call by reference.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo {x:int} (x: (&(int x) >> (int y))): #[y:int] void = let
  val y = x + 1
  val () = x := y * y + 1
in
  
end

fun pml$init (): void = let
  var y: int?
  var x:int = 2
  val () = $extfcall (void, "printf", "old x is %d", x)
  val ()  = inline$foo (x)
  val () = $extfcall (void, "printf", "new x is %d", x)
in 
end




