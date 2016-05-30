/*
* This file is for testing the usage of "if" branch
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$fact (x: int, res: int): void = 
if x > 0 then inline$fact (x - 1, x * res)
else let
  val () = $extfcall (
     void, "printf", "ans = %d", res)
in end


fun inline$fact2 (x: int, res: int): void = 
if x > 0 then inline$fact (x - 1, x * res)

fun pml$init (): void = let
  val x = 5
  val () = inline$fact2 (x, 1)
in end


