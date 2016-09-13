
/*
* This file is for testing the usage of pid.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

#include "./Promela.hats"
staload "./Promela.sats"

fun proctype$foo1 (x: int): void = let
  val () = $extfcall (void
            , "printf", "pid is %d in foo1", pml$mypid ())
in end

fun pml$init (): void = let
  val () = $extfcall (void
            , "printf", "pid is %d in init", pml$mypid ())
  val pid1 = pml$run (proctype$foo1 (1))
in end

