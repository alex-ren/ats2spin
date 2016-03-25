
(*
*  gt
*
*)

// #include "share/atspre_define.hats"
// #include "share/atspre_staload.hats"

datatype type0 =
| TYPE0_int
| TYPE0_fun of (type0lst, type0)

where
type0lst = List0 type0

abstype i0id = ptr
abstype i0sym = ptr

datatype i0ins =
| INS0assign of (i0id, i0exp)
| INS0label of (i0id)
| INS0return of (i0exp)
| INSbranch of (i0inslst (*if*), i0inslst (*else*))
| INSgoto of (i0id)

and i0exp =
| EXP0int of (int)
| EXP0var of (i0id)
| EXP0app of (i0id, i0explst)
| EXP0appsym of (i0sym, i0explst)

where
i0inslst = List0 i0ins
and
i0explst = List0 i0exp

abstype fundef = ptr

staload "./../utils/mymap.sats"
staload "./../postiats/utfpl.sats"

typedef i0gvar = (i0id, Option i0exp)
typedef funmap = mylinmap (i0id, fundef)

typedef i0prog = (
  funmap  // all functions
  , List0 i0gvar  // global variables
  )

// map of functions

fun transform_d2eclst (d2ecs: d2eclist): i0prog

fun transform_d2ecl (d2ec: d2ecl, fmap: funmap, gvs: List0 i0gvar): void






