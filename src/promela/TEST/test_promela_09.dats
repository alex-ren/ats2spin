
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
             , "x is %d\\n"
             , x
             )
in
  inline$foo2 (x, y)
end
and inline$foo2 (x: int, y: int): void = let
  val y = y + 1
  val () = $extfcall (void
             , "printf"
             , "y is %d\\n"
             , y
             )
in
  if y < 10 then inline$foo1 (x, y)
end


fun inline$fooa1 (a: int, x: &int, y: &int): void = let
  val () = x := x + 1
  val () = y := y + 2
  val () = $extfcall (void
             , "printf"
             , "x is %d\\n"
             , x
             )
in
  inline$fooa2 (x, a + 1, y)
end
and inline$fooa2 (x: &int, b: int, y: &int): void = let
  val () = x := x + 3
  val () = y := y + 4
  val () = $extfcall (void
             , "printf"
             , "y is %d\\n"
             , y
             )
in
  if y < 100 then inline$fooa1 (b + 1, x, y)
end

fun pml$init (): void = let
  val x = 1
  val () = inline$foo1 (x, 1)

  var x: int = 0
  var y: int = 0
  val () = inline$fooa1 (0, x, y)
in 
end
