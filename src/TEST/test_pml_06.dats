
/*
* This file is for testing the invocation of inline functions.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (x: int): void = let
  val y = x + 1
in
end

fun pml$init (): void = let
  val x = 3  // inline$foo (2)
  val () = $extfcall (void, "printf", "x is %d", x)
in 
end

