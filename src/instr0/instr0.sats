
(*
*  gt
*
*)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datatype type0 =
| TYPE0_int
| TYPE0_fun of (type0lst, type0)

where
type0lst = List0 type0

abstype i0var = ptr
abstype i0sym = ptr

datatype i0ins =
| INS0assign of (i0var, i0exp)
| INS0label of (i0var)
| INS0return of (i0exp)
| INSbranch of (i0inslst (*if*), i0inslst (*else*))

and i0exp =
| EXP0int of (int)
| EXP0var of (i0var)
| EXP0app of (i0var, i0explst)
| EXP0appsym of (i0sym, i0explst)

where
i0inslst = List0 i0ins
and
i0explst = List0 i0exp

// map of functions
// global variable





