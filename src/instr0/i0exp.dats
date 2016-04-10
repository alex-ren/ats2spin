
#include "share/atspre_staload.hats"

staload "./instr0.sats"

local
#include "./instr0_codegen2.hats"

// todo
implement 
fprint_i0exp$carg<i0id> (out, i0exp) = fprint (out, "")
implement 
fprint_i0exp$carg<i0explst> (out, i0exp) = fprint (out, "")

in
implement 
myfprint_i0exp (out, i0exp) = fprint_i0exp<> (out, i0exp)
end  // end of [local]

implement fprint_val<i0exp> = myfprint_i0exp

