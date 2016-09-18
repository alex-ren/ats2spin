

/*
* This file is for testing recursive inline function.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (x: int, y: int): void = let
  val y = x + 1
  val () = $extfcall (void
             , "printf"
             , "y is %d "
             , y
             )
in
  if y < 4 then inline$foo (y, x)
end

fun inline$foo1 (x: &int, y: &int): void = let
  val () = x := x + 1
  val () = $extfcall (void
             , "printf"
             , "x is %d "
             , x
             )
in
  if x < 4 then inline$foo1 (x, y)
end


fun pml$init (): void = let
  val x = 1
  val ()  = inline$foo (x, 2)

  var x: int = 0
  var y: int = 0
  val ()  = inline$foo1 (x, y)
in 
end

