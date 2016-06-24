
#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

staload "./instr0.sats"
staload "./../postiats/postiats.sats"


staload _(*anon*) = "libats/ML/DATS/list0.dats"

implement fprint_val<i0exp> = myfprint_i0exp
implement fprint_val<d2con> = fprint_d2con

staload _(*anon*) = "./instr0.dats"
#include "./instr0_codegen2.hats"

implement(a)
fprint_i0exp$carg<list0 (a)> (out, xs) =
  fprint_list0<a> (out, xs)

implement 
myfprint_i0exp (out, i0exp) = fprint_i0exp<> (out, i0exp)


