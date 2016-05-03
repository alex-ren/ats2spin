


staload "libats/ML/SATS/basis.sats"

staload "./../instr0/instr0.sats"

staload "./../utils/emiter.sats"

staload "./../postiats/utfpl.sats"

fun pml_emit_i0prog (i0prog: i0prog): emit_unit

#define PROCTYPE "proctype$"
#define INLINE "inline$"

abstype pml_name = ptr

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

and 
pml_step =
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
// | PMLSTMNT_c_code
// | PMLSTMNT_c_expr

and
pml_ivar = 
| PMLIVAR_exp of (pml_name, bool (*is constant*), pml_exp)
| PMLIVAR_chan of (pml_name, bool (*is constant*), pml_chan_init)
| PMLIVAR_name of (pml_name)

and
pml_type = 
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

and pml_exp =
| PMLEXP_anyexp of (pml_anyexp)
| PMLEXP_chanop of (pml_varref)

and pml_anyexp =
| PMLANYEXP_binarop of (pml_binarop, pml_anyexp, pml_anyexp)
| PMLANYEXP_unarop of (pml_unarop, pml_anyexp)
| PMLANYEXP_select of (pml_anyexp, pml_anyexp, pml_anyexp) (* x -> a : b *)
// | PMLANYEXP_len
// | PMLANYEXP_recv_poll
// | PMLANYEXP_varref
// | PMLANYEXP_const
// | PMLANYEXP_timeout
// | PMLANYEXP_np (* non-progress system state *)
// | PMLANYEXP_enabled (pml_anyexp)
// | PMLANYEXP_pc_value (pml_anyexp)
// | PMLANYEXP_name (pml_name, pml_anyexp, pml_name)
// | PMLANYEXP_run (pml_name, pml_arglst, pml_priority_opt)

and
pml_binarop =
| PMLBINAROP_plus
| PMLBINAROP_minus
| PMLBINAROP_and
| PMLBINAROP_or

and
pml_unarop =
| PMLUNAROP_neg   (* ~ *)
| PMLUNAROP_minus (* - *)
| PMLUNAROP_ban   (* ! *)

and (* x[y].z[2] *)
pml_varref = 
| PMLVARREF of (pml_name, option0 pml_anyexp, option0 pml_varref)

where 
pml_ivarlst = list0 pml_ivar

and
pml_uname = symbol

and
pml_typelst = list0 pml_type

and
pml_decl = '{
  pml_decl_visible = bool
  , pml_decl_type = pml_type
  , pml_decl_ivarlst = pml_ivarlst
}


and
pml_declst = list0 pml_decl

and 
pml_steplst = list0 pml_step

and
pml_options = list0 pml_steplst

and
pml_chan_init = '{
  PMLCHANINIT_cap = int
  , PMLCHANINIT_typelst = pml_typelst
}

and
pml_proctype = '{
  pml_proctype_name = pml_name
  , pml_proctype_paralst = pml_declst
  , pml_proctype_seq = pml_steplst
}

and
pml_inline = '{
  pml_inline_name = pml_name
  , pml_inline_paralst = list0 pml_name
  , pml_inline_seq = pml_steplst
}

and
pml_modulelst = list0 pml_module

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

fun pml_name_get_name (pml_name): string

fun pml_name_get_type (pml_name): pml_type

fun pml_name_make (string, stamp, pml_type): pml_name

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
fun pmltransform_i0exp (i0exp): pml_exp









