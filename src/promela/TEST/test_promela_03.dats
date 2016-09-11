/*
* This file is for testing the usage of extfcall.
* 
*/

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun proctype$foo {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = $extfcall (void, "printf", "x is %d", 3)
  // val z = $extfcall (int, "xxx", "x is %d", 3)
in
end

fun pml$init (): void = let
  val _ = pml$run (proctype$foo (1, 2))
in
end


