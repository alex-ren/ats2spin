


(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

(* ****** ****** *)

staload "./postiats.sats"

#include "./postiats_codegen2.hats"

(* ****** ****** *)
implement fprint_val<s2cst> = fprint_s2cst
implement fprint_val<s2var> = fprint_s2var
implement fprint_val<symbol> = fprint_symbol
implement fprint_val<s2exp> = fprint_s2exp
implement fprint_val<labs2exp> = fprint_labs2exp
implement fprint_val<s2rt> = fprint_s2rt
implement fprint_val<wths2explst> = myfprint_wths2explst

(* ************ ************* *)

implement s2exp_make_node (srt, node) =
'{ s2exp_sort = srt
, s2exp_node = node
}

implement fprint_s2exp (out, s2exp) = let
  val () = fprint (out, "{")
  val () = myfprint_s2exp_node (out, s2exp.s2exp_node)
  val () = fprint (out, ", ")
  val () = fprint_s2rt (out, s2exp.s2exp_sort)
  val () = fprint (out, "}")
in end

implement myfprint_s2exp_node (out, node) = fprint_s2exp_node<> (out, node)

implement myfprint_wths2explst (out, wths2explst) = 
  fprint_wths2explst<> (out, wths2explst)

implement fprint_labs2exp (out, labs2exp) = let
  val () = fprint_label (out, labs2exp.labs2exp_label)
  val () = fprint (out, ": ")
  val () = fprint_s2exp (out, labs2exp.labs2exp_s2exp)
in end


