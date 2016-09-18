
/*
* This file is for testing the usage of "case RANDOM".
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"


datatype message =
| START of (int)
| END of (int, int)
| MIDDLE


extern fun recv {a:t@ype} (ch: int): a

fun inline$foo (ch: int): void = let
  val x = 1
in
  case+ pml$random of
  | 0 => let
    val- START (x)  = recv{message} (ch)
    val () = $extfcall (void, "printf", "x is %d\\n", x)
  in end
  | 1 => let
    val- END (x, y) = recv{message} (ch)
    val () = $extfcall (void, "printf", "y is %d\\n", y)
  in end
  | _ => let
    val () = $extfcall (void, "printf", "this is branch else\\n")
  in end
end


