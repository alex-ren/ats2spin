


staload "libats/ML/SATS/basis.sats"

staload "./../instr0/instr0.sats"

staload "./../utils/emiter.sats"

staload "./../postiats/postiats.sats"

(* ********** ************ *)

(*
* The syntax below is rewritten from the section Garmmar Rules
* that is in the book
* "The SPIN Model Checker", Chapter 16 Promela Language Reference.
*)

(* ********** ************ *)
#define PML_NAME_FOR_CTOR "tag"

(* ********** ************ *)

abstype pml_name = ptr

val pml_name_tag: pml_name

fun fprint_pml_name : (FILEref, pml_name) -> void
overload fprint with fprint_pml_name

(* ********** ************ *)

abstype pml_uname = ptr
fun pml_uname_create (symbol): pml_uname
fun tostring_pml_uname (pml_uname): string
overload .tostring with tostring_pml_uname
fun fprint_pml_uname : (FILEref, pml_uname) -> void
overload fprint with fprint_pml_uname


(* ********** ************ *)

datatype pml_type = 
| PMLTYPE_bit
| PMLTYPE_bool
| PMLTYPE_byte
| PMLTYPE_pid
| PMLTYPE_short
| PMLTYPE_int
| PMLTYPE_mtype
| PMLTYPE_chan
| PMLTYPE_uname of pml_uname (* user defined types *)
| PMLTYPE_ignore

fun{} datcon_pml_type (pml_type): string
fun{} fprint_pml_type : (FILEref, pml_type) -> void // a function template
fun myfprint_pml_type : (FILEref, pml_type) -> void // a function template
overload fprint with myfprint_pml_type

typedef
pml_typelst = list0 pml_type
fun fprint_pml_typelst : (FILEref, pml_typelst) -> void
overload fprint with fprint_pml_typelst

(* ********** ************ *)

typedef
pml_chan_init = '{
  pml_chan_init_cap = int
  , pml_chan_init_typelst = pml_typelst
}

fun fprint_pml_chan_init : (FILEref, pml_chan_init) -> void
overload fprint with fprint_pml_chan_init

(* ********** ************ *)

datatype pml_atom =
| PMLATOM_int of (int)   
| PMLATOM_i0nt of (string)   
| PMLATOM_bool of (bool)   
| PMLATOM_char of (char)   

fun{} datcon_pml_atom (pml_atom): string
fun fprint_pml_atom : (FILEref, pml_atom) -> void
overload fprint with fprint_pml_atom

datatype
pml_opr =
| PMLOPR_plus
| PMLOPR_minus
| PMLOPR_mul
| PMLOPR_div
| PMLOPR_gt
| PMLOPR_gte
| PMLOPR_lt
| PMLOPR_lte
| PMLOPR_and
| PMLOPR_or
| PMLOPR_eq
| PMLOPR_neg   (* ~ *)
| PMLOPR_ban   (* ! *)
// | PMLOPR_run

fun{} datcon_pml_opr (pml_opr): string
fun fprint_pml_opr : (FILEref, pml_opr) -> void
overload fprint with fprint_pml_opr

(* ********** ************ *)

datatype pml_anyexp =
| PMLANYEXP_binarop of (pml_opr, pml_anyexp, pml_anyexp)
| PMLANYEXP_unarop of (pml_opr, pml_anyexp)
// x -> a : b
| PMLANYEXP_select of (pml_anyexp, pml_anyexp, pml_anyexp)
// | PMLANYEXP_len
// | PMLANYEXP_recv_poll
| PMLANYEXP_varref of pml_varref  // e.g. arr[2]
| PMLANYEXP_const of pml_atom
| PMLANYEXP_fcall of (string, pml_anyexplst)
// used as argument for fcall
| PMLANYEXP_string of (string)
// | PMLANYEXP_timeout
// | PMLANYEXP_np (* non-progress system state *)
// | PMLANYEXP_enabled (pml_anyexp)
// | PMLANYEXP_pc_value (pml_anyexp)
// | PMLANYEXP_name (pml_name, pml_anyexp, pml_name)
| PMLANYEXP_run of (pml_name, pml_anyexplst(*, pml_priority_opt*))
| PMLANYEXP_inline of (pml_name, pml_anyexplst)  // call inline function

and 
(* x[exp].ref *)
pml_varref = 
| PMLVARREF of (pml_name (*name*)
              , option0 pml_anyexp (*exp*)
              , option0 pml_varref (*ref*))
where 
pml_anyexplst = list0 pml_anyexp

fun{} datcon_pml_anyexp (pml_anyexp): string
fun{} fprint_pml_anyexp : (FILEref, pml_anyexp) -> void
fun myfprint_pml_anyexp : (FILEref, pml_anyexp) -> void
overload fprint with myfprint_pml_anyexp

fun{} datcon_pml_varref (pml_varref): string
fun{} fprint_pml_varref : (FILEref, pml_varref) -> void
fun myfprint_pml_varref : (FILEref, pml_varref) -> void
overload fprint with myfprint_pml_varref

(* ********** ************ *)

datatype pml_exp =
// No inline call
| PMLEXP_anyexp of (pml_anyexp)
// Channel operation
| PMLEXP_chanop of (pml_varref)

fun{} datcon_pml_exp (pml_exp): string
fun{} fprint_pml_exp : (FILEref, pml_exp) -> void
fun myfprint_pml_exp : (FILEref, pml_exp) -> void
overload fprint with myfprint_pml_exp

(* ********** ************ *)

datatype
pml_ivar = 
| PMLIVAR_exp of (pml_name (* bool (is constant)*), pml_exp)
| PMLIVAR_chan of (pml_name (* bool (is constant)*), pml_chan_init)
| PMLIVAR_name of (pml_name)

fun{} datcon_pml_ivar (pml_ivar): string
fun{} fprint_pml_ivar : (FILEref, pml_ivar) -> void
fun myfprint_pml_ivar : (FILEref, pml_ivar) -> void
overload fprint with myfprint_pml_ivar

typedef pml_ivarlst = list0 pml_ivar

fun fprint_pml_ivarlst : (FILEref, pml_ivarlst) -> void

(* ********** ************ *)
// [ visible ] typename ivar [',' ivar ] *
typedef pml_decl = '{
  pml_decl_visible = option0 bool
  , pml_decl_type = pml_type
  , pml_decl_ivarlst = pml_ivarlst
}

fun fprint_pml_decl : (FILEref, pml_decl) -> void
overload fprint with fprint_pml_decl

typedef
pml_declst = list0 pml_decl

fun fprint_pml_declst : (FILEref, pml_declst) -> void

(* ********** ************ *)

datatype pml_step =
| PMLSTEP_declst of pml_declst
| PMLSTEP_stmnt of (pml_stmnt)
// | PMLSTEP_xr of (list0 varref) (* read only *)
// | PMLSTEP_xs of (list0 varref) (* write only *)

and 
pml_stmnt =
| PMLSTMNT_if of pml_options
| PMLSTMNT_do of pml_options
| PMLSTMNT_atomic of pml_steplst
| PMLSTMNT_dstep of pml_steplst
| PMLSTMNT_block of pml_steplst  (* { xxx } *)
// | PMLSTMNT_send   // todo
// | PMLSTMNT_receive
| PMLSTMNT_assign of (pml_varref, pml_anyexp)
| PMLSTMNT_else
| PMLSTMNT_break
| PMLSTMNT_goto of pml_name
// Promela needs a label to be attached to a statement.
// So I don't use the following currently.
| PMLSTMNT_name of (pml_name, pml_stmnt)  
// | PMLSTMNT_label of (pml_name)
// | PMLSTMNT_print
| PMLSTMNT_assert of pml_exp
| PMLSTMNT_exp of pml_exp
// Inline call
| PMLSTMNT_inline of (pml_name, list0 pml_anyexp)
// | PMLSTMNT_c_code
// | PMLSTMNT_c_expr


where 
pml_steplst = list0 pml_step

and
pml_options = list0 pml_steplst
// end of [where]

fun{} datcon_pml_step (pml_step): string
fun{} fprint_pml_step : (FILEref, pml_step) -> void
fun myfprint_pml_step : (FILEref, pml_step) -> void
overload fprint with myfprint_pml_step

fun{} datcon_pml_stmnt (pml_stmnt): string
fun{} fprint_pml_stmnt : (FILEref, pml_stmnt) -> void
fun myfprint_pml_stmnt : (FILEref, pml_stmnt) -> void
overload fprint with myfprint_pml_stmnt

fun fprint_pml_steplst : (FILEref, pml_steplst) -> void
overload fprint with fprint_pml_steplst

fun fprint_pml_options : (FILEref, pml_options) -> void
overload fprint with fprint_pml_options

(* ********** ************ *)

typedef
pml_proctype = '{
  pml_proctype_name = pml_name
  , pml_proctype_paralst = pml_declst
  , pml_proctype_seq = pml_steplst
}

fun fprint_pml_proctype : (FILEref, pml_proctype) -> void
overload fprint with fprint_pml_proctype

typedef
pml_inline = '{
  pml_inline_name = pml_name
  , pml_inline_paralst = list0 pml_name
  , pml_inline_seq = pml_steplst
}

fun pml_inline_make (
  pml_name, list0 pml_name, pml_steplst): pml_inline

fun fprint_pml_inline : (FILEref, pml_inline) -> void
overload fprint with fprint_pml_inline

datatype pml_module =
/* user defined types */
| PMLMODULE_utype of (pml_name, pml_declst)
/* mtype declaration */
| PMLMODULE_mtype of (list0 pml_name)
/* global vars, chans */
| PMLMODULE_declst of pml_declst
| PMLMODULE_proctype of pml_proctype
| PMLMODULE_inline of pml_inline
| PMLMODULE_init of pml_steplst
| PMLMODULE_never
| PMLMODULE_c_code
| PMLMODULE_literal_code of string

fun{} datcon_pml_module (pml_module): string
fun{} fprint_pml_module : (FILEref, pml_module) -> void
fun myfprint_pml_module : (FILEref, pml_module) -> void
overload fprint with myfprint_pml_module

(* ******** ********* *)

typedef pml_modulelst = list0 pml_module

fun fprint_pml_program: (FILEref, pml_modulelst) -> void
overload fprint with fprint_pml_program


(* ******** ********* *)

fun pml_decl_make (visible: option0 bool
   , type: pml_type
   , ivarlst: pml_ivarlst
): pml_decl

fun pml_proctype_make (
  name: pml_name
  , paralst: pml_declst
  , seq: pml_steplst
): pml_proctype

(* ******** ********* *)

fun i0exp_is_inline_call (i0exp): bool

(* ******** ********* *)

fun pml_name_get_name (pml_name): string

fun pml_name_get_type (pml_name): pml_type

fun pml_name_get_stamp (pml_name): stamp

fun tostring_pml_name (pml_name): string

fun pml_name_make (string, stamp, pml_type, option0 string (*extdef*)): pml_name

(* ******** ********* *)

fun pml_varref_make (pml_name): pml_varref

(* ******** ********* *)

fun pmltransform_i0prog (dtmap: datatype0map, i0prog: i0prog): pml_modulelst
fun pmltransform_i0decl (i0decl: i0decl): pml_module
fun pmltransform_i0fundef (i0fundef: i0fundef): pml_module

(*
* name: The string without prefix.
*)
fun pmltransform_inline (pml_name: pml_name, i0fundef: i0fundef): pml_module
fun pmltransform_proctype (pml_name: pml_name, i0fundef: i0fundef): pml_module
fun pmltransform_init (i0fundef: i0fundef): pml_module

fun pmltransform_i0id (i0id: i0id): pml_name
fun pmltransform_i0inslst (is_inline: bool, i0inslst: i0inslst): pml_steplst

fun pmltransform_i0type (type0): pml_type

// i0exp is not inline function invocation.
fun pmltransform_i0exp2pml_anyexp (i0exp): pml_anyexp

fun pmltransform_i0explst2pml_anyexplst (i0explst): pml_anyexplst

fun pmltransform_i0id2operator (i0id): option0 pml_opr

fun pmltransform_i0id2decl (i0id): pml_decl

fun i0id_is_run (i0id): bool
fun i0id_is_wait_until (i0id): bool

(* ******** ********* *)

fun emit_pml_program (pml_modulelst): emit_unit
overload emit with emit_pml_program







