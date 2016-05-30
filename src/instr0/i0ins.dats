
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./instr0.sats"

staload _(*anon*) = "./i0exp.dats"
staload _(*anon*) = "./instr0.dats"

implement fprint_val<i0ins> (out, i0ins) = myfprint_i0ins (out, i0ins)

local
#include "./instr0_codegen2.hats"
in

(* *********** ************ *)

implement fprint_i0gbranch (out, gb) = let
  val () = fprint (out, "i0gbranch (")
  val () = myfprint_i0exp (out, gb.i0gbranch_guard)
  val () = fprint (out, ",\n")

  // fprint is overloaded with fprint_list0_sep.
  val () = fprint (out, gb.i0gbranch_inss, "\n")
in end

implement fprint_val<i0gbranch> (out, gb) = fprint_i0gbranch (out, gb)

// implement(a)
// fprint_i0ins$carg<option0 a> (out, arg) = let
// in
// case+ arg of
// // | some0 (c) => fprint_<a> (out, c)
// | some0 (c) => ignoret(fprint_i0ins$carg<a> (out, c))
// | none0 () => let
//   val () = fprint (out, "none")
// in end
// end

implement
fprint_i0ins$carg<i0gbranchlst>(out, arg) = let
  val () = fprint_list0_sep<i0gbranch> (out, arg, "\n")
in end


implement fprint_i0ins$INS0random$lpar<> (out, ins) =
  fprint (out, "(\n")

implement fprint_i0ins$INS0random$sep1<> (out, ins) =
  fprint (out, "\n")

implement fprint_i0ins$INS0random$arg2<> (out, arg0) = let
  val-INS0random(_, arg2) = arg0 
in
  case+ arg2 of
  | Some0 (inss) => let
    val () = fprint (out, "else:\n")
    val () = fprint (out, inss)
    val () = fprint (out, ")")
  in end
  | None0 () => ()
end
                                            

(* *********** ************ *)

implement fprint_i0ins$INS0ifbranch$rpar<> (out, ins) =
  fprint (out, "  end of [if]")

implement fprint_i0ins$INS0ifbranch$sep1<> (out, ins) =
  fprint (out, ",\n")

implement fprint_i0ins$INS0ifbranch$sep2<> (out, ins) =
  fprint (out, " else == \n")

(* *********** ************ *)

implement
fprint_i0ins$INS0tail_jump$lpar<> (out, ins) = let
  val () = fprint (out, "(\n")
in end

implement
fprint_i0ins$INS0tail_jump$rpar<> (out, ins) = let
  val () = fprint (out, "\n)")
in end

implement
fprint_i0ins$INS0tail_jump$sep1<> (out, ins) = let
  val () = fprint (out, ",\n")
in end

(* *********** ************ *)


implement
fprint_i0ins$carg<i0inslst>(out, arg) = let
  val () = fprint (out, "{\n")
  val () = fprint_list0_sep<i0ins> (out, arg, "\n")
  val () = fprint (out, "\n}")
in end

implement myfprint_i0ins (out, i0ins) = 
  fprint_i0ins<> (out, i0ins)

end



