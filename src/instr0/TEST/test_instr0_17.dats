/*
* This file is for testing the usage of "case RANDOM" with tail call.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (): void = let
  val x = 1
in
  case+ pml$random of
  | 0 => let
    val () = pml$wait_until (lam () => true)
    val () = $extfcall (void, "printf", "this is branch 1\\n")
  in 
    inline$foo ()
  end
  | 1 => let
    val () = pml$wait_until (lam () => true)
    val () = $extfcall (void, "printf", "this is branch 2\\n")
  in 
    inline$foo ()
  end
  | _ => let
    val () = pml$wait_until (lam () => false)
    val () = $extfcall (void, "printf", "this is branch end\\n")
  in end
end

fun proctype$foo (): void = inline$foo ()

fun pml$init (): void = let
  val _ = pml$run (proctype$foo ())
in end

