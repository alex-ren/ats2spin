


(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

staload "./postiats.sats"

(* ************ ************* *)

implement s2exp_make_node (srt, node) =
'{ s2exp_sort = srt
, s2exp_node = node
}

implement fprint_s2exp (out, s2exp) = let
  val () = fprint (out, "s2exp")
in end

