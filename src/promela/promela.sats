


staload "libats/ML/SATS/basis.sats"

staload "./../instr0/instr0.sats"

staload "./../utils/emiter.sats"

staload "./../postiats/utfpl.sats"

fun pml_emit_i0prog (i0prog: i0prog): emit_unit

#define PROCTYPE "proctype$"
#define INLINE "inline$"

(* ********** ************ *)

abstype pml_name = ptr

typedef
pml_uname = symbol


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
| PMLTYPE_todo

typedef
pml_typelst = list0 pml_type

(* ********** ************ *)

typedef
pml_chan_init = '{
  PMLCHANINIT_cap = int
  , PMLCHANINIT_typelst = pml_typelst
}

(* ********** ************ *)

datatype pml_atom =
| PMLATOM_INT of (int)   
| PMLATOM_BOOL of (bool)   
| PMLATOM_CHAR of (char)   


datatype
pml_opr =
| PMLOPR_plus
| PMLOPR_minus
| PMLOPR_and
| PMLOPR_or
| PMLOPR_neg   (* ~ *)
| PMLOPR_minus (* - *)
| PMLOPR_ban   (* ! *)

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
// | PMLANYEXP_timeout
// | PMLANYEXP_np (* non-progress system state *)
// | PMLANYEXP_enabled (pml_anyexp)
// | PMLANYEXP_pc_value (pml_anyexp)
// | PMLANYEXP_name (pml_name, pml_anyexp, pml_name)
// | PMLANYEXP_run (pml_name, pml_arglst, pml_priority_opt)

and 
(* x[y].z[2] *)
pml_varref = 
| PMLVARREF of (pml_name, option0 pml_anyexp, option0 pml_varref)

(* ********** ************ *)

datatype pml_exp =
// No inline call
| PMLEXP_anyexp of (pml_anyexp)
// Channel operation
| PMLEXP_chanop of (pml_varref)

(* ********** ************ *)

datatype
pml_ivar = 
| PMLIVAR_exp of (pml_name, bool (*is constant*), pml_exp)
| PMLIVAR_chan of (pml_name, bool (*is constant*), pml_chan_init)
| PMLIVAR_name of (pml_name)

typedef pml_ivarlst = list0 pml_ivar

typedef pml_decl = '{
  pml_decl_visible = bool
  , pml_decl_type = pml_type
  , pml_decl_ivarlst = pml_ivarlst
}

typedef
pml_declst = list0 pml_decl

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
| PMLSTMNT_assign
| PMLSTMNT_else
| PMLSTMNT_break
| PMLSTMNT_goto of pml_name
| PMLSTMNT_name of (pml_name, pml_stmnt)
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

(* ********** ************ *)


typedef
pml_proctype = '{
  pml_proctype_name = pml_name
  , pml_proctype_paralst = pml_declst
  , pml_proctype_seq = pml_steplst
}

typedef
pml_inline = '{
  pml_inline_name = pml_name
  , pml_inline_paralst = list0 pml_name
  , pml_inline_seq = pml_steplst
}


datatype pml_module =
/* user defined types */
| PMLMODULE_utype of (pml_name, pml_declst)
/* mtype declaration */
| PMLMODULE_mtype
/* global vars, chans */
| PMLMODULE_declst of pml_declst
| PMLMODULE_proctype of pml_proctype
| PMLMODULE_inline of pml_inline
| PMLMODULE_init
| PMLMODULE_never
| PMLMODULE_c_code


typedef pml_modulelst = list0 pml_module

fun fprint_pml_program: (FILEref, pml_modulelst) -> void
overload fprint with fprint_pml_program


(* ******** ********* *)

fun pml_decl_make (visible: bool
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

fun pml_name_make (string, stamp, pml_type): pml_name

(* ******** ********* *)

fun pml_varref_make (pml_name): pml_varref

(* ******** ********* *)

fun pmltransform_i0prog (i0prog: i0prog): pml_modulelst
fun pmltransform_i0fundef (i0fundef: i0fundef): pml_module

(*
* name: The string without prefix.
*)
fun pmltransform_inline (pml_name: pml_name, i0fundef: i0fundef): pml_module
fun pmltransform_proctype (pml_name: pml_name, i0fundef: i0fundef): pml_module

fun pmltransform_i0id (i0id: i0id): pml_name
fun pmltransform_i0inslst (i0inslst: i0inslst): pml_steplst

fun pmltransform_i0type (): pml_type

// i0exp is not inline function invocation.
fun pmltransform_i0exp2pml_anyexp (i0exp): pml_anyexp

fun pmltransform_i0id2operator (i0id): option0 pml_opr








