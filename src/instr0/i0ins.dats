

#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

staload "./instr0.sats"

staload _(*anon*) = "libats/ML/DATS/list0.dats"
staload _(*anon*) = "./i0exp.dats"
staload _(*anon*) = "./instr0.dats"

implement fprint_val<i0ins> = myfprint_i0ins

local
#include "./instr0_codegen2.hats"
in
implement(a)
fprint_i0ins$carg<option0 a> (out, arg) = let
in
case+ arg of
| Some0 (c) => fprint_val<a> (out, c)
| None0 () => let
  val () = fprint (out, "none")
in end
end

implement fprint_i0ins$INS0ifbranch$sep1<> (out, ins) =
  fprint (out, ",\n")

implement fprint_i0ins$INS0ifbranch$sep2<> (out, ins) =
  fprint (out, "\n== else == \n")

implement
fprint_i0ins$carg<i0inslst>(out, arg) =
  fprint_list0_sep<i0ins> (out, arg, "\n")

implement myfprint_i0ins (out, i0ins) = 
  fprint_i0ins<> (out, i0ins)
end



