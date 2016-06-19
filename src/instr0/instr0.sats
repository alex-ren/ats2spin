
(*
*
*
*)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "libats/ML/SATS/basis.sats"

staload "./../postiats/postiats.sats"
staload "./../simpletypes/simpletypes.sats"

staload "./../utils/emiter.sats"

(* ********** ************ *)

#define PML_PROCTYPE "proctype$"
#define PML_INLINE "inline$"
#define PML_INIT "pml$init"
#define PML_RUN "pml$run"
#define PML_WAIT_UNTIL "pml$wait_until"

(* ********** ************ *)

datatype type0 =
| TYPE0int
| TYPE0char
| TYPE0bool
| TYPE0unit  // void
| TYPE0fun of (type0lst, type0)
| TYPE0ref of (type0)
| TYPE0symbol of (symbol)  // from S3TYPEcon
| TYPE0datatype of (type0ctrorlst)
| TYPE0ignored of ()
where
type0lst = list0 type0

and
type0ctror = '(symbol, type0lst)
and
type0ctrorlst = list0 type0ctror

(* ********** ************ *)

fun{} fprint_type0: fprint_type (type0)
fun myfprint_type0: fprint_type (type0)
overload fprint with myfprint_type0

fun{} datcon_type0: type0 -> string

fun type0_is_ref (type0): bool

fun type0_translate (s3type): type0
fun type0_translate_s3typelst (s3typelst): type0lst

abstype i0name = ptr
fun i0name_make (s: symbol): i0name
fun i0name_get_symbol (n: i0name): symbol
fun fprint_i0name: (FILEref, i0name) -> void
overload fprint with fprint_i0name

fun eq_i0name_i0name (n1: i0name, n2: i0name):<fun0> bool
overload = with eq_i0name_i0name

fun emit_i0name (i0name): emit_unit
fun tostring_i0name(i0name): string

(* ************ ************** *)

abstype stamp_allocator = ptr
fun stamp_allocator_create (): stamp_allocator

fun stamp_allocate (allocator: stamp_allocator): stamp

(* ************ ************** *)

datatype i0id_cat =
| I0ID_gvar
| I0ID_fname
| I0ID_para
| I0ID_other

(* ************ ************** *)

// typedef i0id = '{
// //  i0id_cat = i0id_cat
// , i0id_name = i0name
// , i0id_stamp = stamp
// // , i0id_type = type0
// }

abstype i0id = ptr

fun i0id_make_sym (i0name): i0id
fun i0id_make_cst (i0name, stamp, option0 string, type0): i0id
fun i0id_make_var (i0name, stamp, type0): i0id
fun i0id_is_sym (i0id): bool
fun i0id_is_cst (i0id): bool
fun i0id_is_var (i0id): bool
fun i0id_get_name (i0id):<fun> i0name
fun i0id_get_stamp (i0id):<fun> stamp
fun i0id_get_type (i0id):<fun> type0
fun i0id_get_extdef (i0id): option0 string

typedef i0idlst = list0 i0id

fun fprint_i0id: (FILEref, i0id) -> void
overload fprint with fprint_i0id

fun i0id_copy (i0id: i0id, sa: stamp_allocator): i0id
fun i0id_copy_remove_prefix_inline (i0id: i0id, sa: stamp_allocator): i0id

fun eq_i0id_i0id (x: i0id, y: i0id):<fun0> bool
overload = with eq_i0id_i0id

fun emit_i0id (i0id): eu

// Stamp is part of the output
fun tostring_i0id (i0id): string

// Just the name, no stamp
fun tostring_i0id_name (i0id): string

(* ************* *************** *)

datatype i0ins =
| INS0decl of (i0id, option0 i0exp)
//
| INS0assign of (option0 i0exp, i0exp)
//
| INS0label of (i0id)
//
| INS0return of (option0 i0exp)
//
| INS0ifbranch of (i0exp, i0inslst (*if*), i0inslst (*else*))
//
| INS0random of (i0gbranchlst, i0inslstopt) 
//
| INS0goto of (i0id)
//
// Added for recursive functions
| INS0init_loop of (
  i0idlst (*all variables*)
  , list0 (@(i0id, i0id)) (*variabe and initial value from para*))
//
// Added for recursive functions
| INS0tail_jump of (i0inslst (*calc arg*), i0id (*jump tag*))

and i0exp =
| EXP0int of (int)
| EXP0i0nt of (string)
| EXP0string of (string)
| EXP0var of (i0id)
| EXP0app of (i0id, i0explst)
| EXP0extfcall of (string, i0explst)
| EXP0lambody of (i0exp)

where
i0inslst = list0 i0ins
and
i0inslstopt = option0 i0inslst
and
i0explst = list0 i0exp
and
i0gbranch = '{
  i0gbranch_guard = i0exp
  , i0gbranch_inss = i0inslst
}
and
i0gbranchopt = option0 i0gbranch
and
i0gbranchlst = list0 i0gbranch

fun fprint_i0gbranch (FILEref, i0gbranch): void

fun i0gbranch_make (i0exp, i0inslst): i0gbranch

fun{} fprint_i0exp : (FILEref, i0exp) -> void // a function template
fun{} fprint_i0ins : (FILEref, i0ins) -> void // a function template

fun myfprint_i0exp: (FILEref, i0exp) -> void
overload fprint with myfprint_i0exp
fun myfprint_i0ins: (FILEref, i0ins) -> void
overload fprint with myfprint_i0ins

fun{} datcon_i0exp (i0exp): string
fun{} datcon_i0ins (i0ins): string

(* ************ ************* *)

abstype i0fundef = ptr
fun i0fundef_create (
  name: i0id
  , paralst: i0idlst
  , inss: i0inslst
  , group: i0idlst
  ): i0fundef

fun fprint_i0fundef : (FILEref, i0fundef) -> void
overload fprint with fprint_i0fundef

fun i0fundef_get_id (f: i0fundef): i0id

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
fun i0fundef_get_group (f: i0fundef): i0idlst

fun i0fundef_get_paralst (f: i0fundef): i0idlst

(* ************ ************* *)

staload HT = "libats/ML/SATS/hashtblref.sats"

// Desc: Not used yet.
typedef i0gvar = (i0id, Option i0exp)
typedef i0gvarlst = list0 i0gvar

fun fprint_i0gvar: (FILEref, i0gvar) -> void
overload fprint with fprint_i0gvar

(* ************* *************** *)

// mapping id to function body
typedef i0funmap = $HT.hashtbl (i0id, i0fundef)

fun i0funmap_create (sz: sizeGte(1)): i0funmap
fun i0funmap_insert_any (i0funmap, i0id, i0fundef): void
fun i0funmap_listize1 (i0funmap): list0 @(i0id, i0fundef)
// must exist in the map
fun i0funmap_search0 (i0funmap, i0id: i0id): i0fundef

(******** ********** *********)

typedef i0idmap = $HT.hashtbl (i0id, i0id)
fun i0idmap_create (sz: sizeGte(1)): i0idmap
fun i0idmap_insert_any (i0idmap, i0id, i0id): void
fun i0idmap_listize1 (i0idmap): list0 @(i0id, i0id)
fun i0idmap_search (i0idmap, i0id): Option_vt i0id

(******** ********** *********)

datatype i0decl =
| DEC0fun of i0fundef
| DEC0extcode of string
| DEC0gvar of i0gvar

typedef i0declst = list0 i0decl

fun{} fprint_i0decl : (FILEref, i0decl) -> void // a function template
fun myfprint_i0decl: (FILEref, i0decl) -> void
overload fprint with myfprint_i0decl

(******** ********** *********)


typedef i0prog = '{
  i0prog_i0funmap = i0funmap  // ease the process for finding a function
  , i0prog_i0declst = i0declst
  // , i0prog_i0gvarlst = i0gvarlst  // global variables
  }

fun fprint_i0prog: (FILEref, i0prog) -> void
overload fprint with fprint_i0prog

(* ************ ************* *)

fun stamp_get_from_d2var (
  allocator: stamp_allocator
  , d2var: d2var
): stamp

fun stamp_get_from_d2cst (
  allocator: stamp_allocator
  , d2cst: d2cst
): stamp

// fun stamp_get_from_d2sym (
//   allocator: stamp_allocator
//   , d2sym: d2sym
// ): stamp

(* ************ ************* *)

fun i0transform_d2eclst_global (
  sa: stamp_allocator
  , d2ecs: d2eclist
  , tmap: s3typemap
  ): i0prog

fun i0transform_d2ecl_global (
  sa: stamp_allocator
  , d2ec: d2ecl
  , tmap: s3typemap
  , fmap: i0funmap): i0declst

fun i0transform_D2Cfundecs (
  sa: stamp_allocator
  , f2undeclst: f2undeclst
  , tmap: s3typemap
  , fmap: i0funmap
  ): i0declst

(* Desc: Create fundef and put it into the fmap
*    group: Containing the names of the mutually recursive functions.
*           Can be list0_nil () if the function is not a recursive
*           function.
*)
fun i0transform_fundec (
  sa: stamp_allocator
  , group: i0idlst
  , f2undec: f2undec
  , tmap: s3typemap
  , fmap: i0funmap): i0declst (*inner functions are included*)
                  
fun i0transform_d2var (
  sa: stamp_allocator
  , tmap: s3typemap
  , d2var: d2var): i0id

fun i0transform_d2cst (
  sa: stamp_allocator
  , tmap: s3typemap
  , d2cst: d2cst): i0id

fun i0transform_d2sym (
  sa: stamp_allocator
  , d2sym: d2sym): i0id

fun i0transform_p2atlst2paralst (
  sa: stamp_allocator
  , tmap: s3typemap
  , p2atlst: p2atlst): i0idlst

fun i0transform_p2at2para (
  sa: stamp_allocator
  , tmap: s3typemap
  , p2at: p2at): i0id

fun i0transform_p2at2holder (
  sa: stamp_allocator
  , tmap: s3typemap
  , p2at: p2at): option0 i0id

(*
* Desc: Turn an expression into the instruction list computing
* the expression. The innermost instruction should be INS0return.
*)
fun i0transform_d2exp_fbody (
  sa: stamp_allocator
  , e: d2exp
  , tmap: s3typemap
  , fmap: i0funmap): (i0declst (*inner functions*), i0inslst)

fun i0transform_d2exp_fname (
  sa: stamp_allocator
  , tmap: s3typemap
  , e: d2exp): i0id

(*
* The whole expression is translated into one expression.
* todo: Write effect shall not be allowed inside.
*)
fun i0transform_d2exp_expvalue (
  sa: stamp_allocator
  , tmap: s3typemap
  , e: d2exp
): i0exp

fun i0transform_d2exparglst (
  sa: stamp_allocator
  , tmap: s3typemap
  , d2exparglst: d2exparglst): i0explst

fun i0transform_d2explst_expvalue (
  sa: stamp_allocator
  , tmap: s3typemap
  , d2explst: d2explst): i0explst

fun i0transform_d2eclist (
  sa: stamp_allocator
  , d2eclist: d2eclist
  , tmap: s3typemap
  , fmap: i0funmap): (i0declst, i0inslst)

fun i0transform_d2ecl (
  sa: stamp_allocator
  , d2ecl: d2ecl
  , tmap: s3typemap
  , fmap: i0funmap): (i0declst (*inner function*), i0inslst)

fun i0transform_D2Cvaldecs (
  sa: stamp_allocator
  , tmap: s3typemap
  , v2aldeclst: v2aldeclst): i0inslst

fun i0transform_D2Cvardecs (
  sa: stamp_allocator
  , tmap: s3typemap
  , v2ardeclst: v2ardeclst): i0inslst

fun i0transform_v2aldec (
  sa: stamp_allocator
  , tmap: s3typemap
  , v2aldec: v2aldec): i0ins (* INS0assign *)

fun i0transform_v2aldec2guardexp (
  sa: stamp_allocator
  , tmap: s3typemap
  , v2aldec: v2aldec): i0exp

fun i0transform_v2ardec (
  sa: stamp_allocator
  , tmap: s3typemap
  , v2aldec: v2ardec): i0ins (* INS0assign *)

(* ********** *********** *)

fun i0optimize_tailcall (
  sa: stamp_allocator
  , i0prog: i0prog
): i0prog

// Note: It's possible that i0fundef is not tail-recursive.
//       Then we simply return the i0fundef.
fun i0optimize_tailcall_fundef (
  sa: stamp_allocator
  , i0fundef: i0fundef
  , funmap: i0funmap
): i0fundef

(* ********** *********** *)

(*
* Turn "int x = 3" into "int x; x = 3;" 
* and move all declarations to the beginning.
*)
fun i0optimize_collect_decs (i0prog: i0prog): i0prog

fun i0optimize_collect_decs_fundef (i0fundef: i0fundef): i0fundef





