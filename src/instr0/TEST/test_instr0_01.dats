
/*
* This file is for testing generating proctype.
*
*/

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun proctype$foo {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = $extfcall (void, "printf", "x is %d", 3)
in
end






