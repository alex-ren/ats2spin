


/*
* This file is for testing the usage of operators
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

#include "./Promela.hats"
staload "./Promela.sats"


fun pml$init (): void = let
  val x = 1 + 1
  val x = x - 1
  val x = x * 1
  val x = x / 1
  val y = ~x
  val () = pml$assert (2 > 1)
  val () = pml$assert (2 >= 1)
  val () = pml$assert (1 < 2)
  val () = pml$assert (1 <= 2)
  val () = pml$assert ((2 > 1) * (3 > 2))
  val () = pml$assert ((2 > 1) + (3 > 2))
  val () = pml$assert (3 = 3)
  val () = pml$assert (~(3 = 3))
in end
