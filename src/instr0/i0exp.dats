
#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

staload "./instr0.sats"


staload _(*anon*) = "libats/ML/DATS/list0.dats"

implement fprint_val<i0exp> = myfprint_i0exp

local

staload _(*anon*) = "./instr0.dats"
#include "./instr0_codegen2.hats"

implement(a)
fprint_i0exp$carg<list0 (a)> (out, xs) =
  fprint_list0<a> (out, xs)

in
implement 
myfprint_i0exp (out, i0exp) = fprint_i0exp<> (out, i0exp)
end  // end of [local]


