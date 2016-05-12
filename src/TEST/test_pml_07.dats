
/*
* This file is for testing the usage of call by reference.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo {x:int} (x: &int x >> int 1): void = let
  val y = x + 1
  val () = x := 1
in
end

fun pml$init (): void = let
  var x
  val _  = inline$foo (x)
in 
end

