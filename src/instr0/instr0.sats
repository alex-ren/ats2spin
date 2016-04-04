
(*
*
*
*)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"

staload "./../postiats/utfpl.sats"


datatype type0 =
| TYPE0_int
| TYPE0_unit  // void
| TYPE0_fun of (type0lst, type0)
where
type0lst = list0 type0

abstype i0name = ptr

fun i0name_get_symbol (n: i0name): symbol
fun i0name_get_type (n: i0name): type0

datatype i0id_cat =
| I0ID_gvar
| I0ID_para
| I0ID_other

typedef i0id = '{
  i0id_cat = i0id_cat
, i0id_name = i0name
, i0id_stamp = stamp
, i0id_type = type0
}

typedef i0idlst = list0 i0id

fun i0name_get_stamp (n: i0name): stamp

datatype i0ins =
| INS0assign of (i0id, i0exp)
| INS0label of (i0id)
| INS0return of (i0exp)
| INSifbranch of (i0exp, i0inslst (*if*), i0inslst (*else*))
| INSgoto of (i0id)

and i0exp =
| EXP0int of (int)
| EXP0var of (i0id)
| EXP0app of (i0id, i0explst)
// | EXP0appsym of (i0sym, i0explst)

where
i0inslst = list0 i0ins
and
i0explst = list0 i0exp

abstype i0fundef = ptr
fun i0fundef_get_instructions (f: i0fundef): i0inslst

// Desc: recursive call which is not tail call, is not allowed
// Ret is true iff this function is a single recursive function
// or a member of a group of mutually recursive functions.
fun i0fundef_is_recursive (f: i0fundef): bool

(* Desc: Return all the functions in the group of mutually
 * recursive functions. The function itself is included.
 * Note: If the function is simply tail recursive function,
 *       then the list would contain itself.
*)
fun i0fundef_get_group (f: i0fundef): list0 i0id

staload HT = "libats/ML/SATS/hashtblref.sats"
staload "./../postiats/utfpl.sats"

// Desc: Not used yet.
typedef i0gvar = (i0id, Option i0exp)
typedef i0gvarlst = list0 i0gvar

// mapping id to function body
typedef i0funmap = $HT.hashtbl (i0id, i0fundef)

typedef i0prog = (
  i0funmap  // all functions
  , i0gvarlst  // global variables
  )


fun i0transform_d2eclst_global (d2ecs: d2eclist): i0prog

fun i0transform_d2ecl_global (d2ec: d2ecl, fmap: i0funmap, gvs: &i0gvarlst): void

fun i0transform_D2Cfundecs (
  f2undeclst: f2undeclst, fmap: i0funmap, gvs: &i0gvarlst): void

// todo: assume the function doesn't contains recursive call.
fun i0transform_f2undec_nonrecurive (
  f2undec: f2undec, fmap: i0funmap, gvs: &i0gvarlst): void

fun i0transform_d2var (d2var: d2var): i0id




