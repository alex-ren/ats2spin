
/*
* This file is for testing mutually recursive inline functions.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo1 (x: int, y: int): void = let
  val x = x + 1
  val () = $extfcall (void
             , "printf"
             , "x is %d"
             , x
             )
in
  inline$foo2 (x, y)
end
and inline$foo2 (x: int, y: int): void = let
  val y = y + 1
  val () = $extfcall (void
             , "printf"
             , "y is %d"
             , y
             )
in
  inline$foo1 (x, y)
end


fun pml$init (): void = let
  val x = 1
  val _  = inline$foo1 (x, 1)
in 
end
