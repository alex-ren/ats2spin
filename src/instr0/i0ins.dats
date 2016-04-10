

#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"

staload "./instr0.sats"


staload _(*anon*) = "./i0exp.dats"
staload _(*anon*) = "./instr0.dats"

local
#include "./instr0_codegen2.hats"
in
implement(a)
fprint_i0ins$carg<option0 a> (out, arg) = let
in
case+ arg of
| Some0 (c) => fprint_i0ins$carg<a> (out, c)
| None0 () => let
  val () = fprint (out, "(empty)")
in end
end

implement{}
fprint_i0ins$INS0return(out, arg0) = ()

implement{}
fprint_i0ins$INS0ifbranch(out, arg0) = ()

implement myfprint_i0ins (out, i0ins) = 
  fprint_i0ins<> (out, i0ins)
end

implement fprint_val<i0ins> = myfprint_i0ins

