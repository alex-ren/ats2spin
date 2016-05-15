

/*
* This file is for testing the usage of assert
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

#include "./Promela.hats"
staload "./Promela.sats"


fun pml$init (): void = let
  val x = 2
  val () = pml$assert (x > 1)
in end



