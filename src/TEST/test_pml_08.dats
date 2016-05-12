

/*
* This file is for testing recursive inline function.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (x: int, y: int): void = let
  val y = x + 1
in
  inline$foo (y, x)
end

fun pml$init (): void = let
  val x = 1
  val _  = inline$foo (x, 2)
in 
end

