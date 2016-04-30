


staload "libats/ML/SATS/basis.sats"

staload "./../instr0/instr0.sats"

staload "./../utils/emiter.sats"

staload "./../postiats/utfpl.sats"

fun pml_emit_i0prog (i0prog: i0prog): emit_unit

#define PROCTYPE "proctype$"
#define INLINE "inline$"

datatype pml_module =
/* user defined types */
| PMLMODULE_utype of (pml_name, pml_declst)
| PMLMODULE_mtype
| PMLMODULE_declst of pml_declst
| PMLMODULE_proctype of pml_proctype
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
| PMLSTMNT_atomic of pml_sequence
| PMLSTMNT_dstep of pml_sequence
| PMLSTMNT_block of pml_sequence  (* { xxx } *)
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

and
pml_typename = 
| PMLTYPENAME_bit
| PMLTYPENAME_bool
| PMLTYPENAME_byte
| PMLTYPENAME_pid
| PMLTYPENAME_short
| PMLTYPENAME_int
| PMLTYPENAME_mtype
| PMLTYPENAME_chan
| PMLTYPENAME_uname of pml_uname (* user defined typenames *)

and pml_exp =
| PMLEXP_anyexp of (pml_anyexp)
| PMLEXP_andor of (pml_andor, pml_exp, pml_exp)
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
| PMLBINAROP_andor of pml_andor

and
pml_unarop =
| PMLUNAROP_neg   (* ~ *)
| PMLUNAROP_minus (* - *)
| PMLUNAROP_ban   (* ! *)

and 
pml_andor =
| PMLANDOR_and
| PMLANDOR_or

and (* x[y].z[2] *)
pml_varref = 
| PMLVARREF of (pml_name, option0 pml_anyexp, option0 pml_varref)

where 
pml_ivarlst = list0 pml_ivar

and
pml_name = symbol

and
pml_uname = symbol

and
pml_typenamelst = list0 pml_typename

and
pml_decl = '{
  pml_decl_visible = bool
  , pml_decl_typename = pml_typename
  , pml_decl_ivar = pml_ivarlst
}


and
pml_declst = list0 pml_decl

and 
pml_sequence = list0 pml_step

and
pml_options = list0 pml_sequence

and
pml_chan_init = '{
  PMLCHANINIT_cap = int
  , PMLCHANINIT_typelst = pml_typenamelst
}

and
pml_proctype = '{
  PMLPROCTYPE_name = pml_name
  , PMLPROCTYPE_declst = pml_declst
  , PMLPROCTYPE_seq = pml_sequence
}

and
pml_spec = list0 pml_module

(* ******** ********* *)

fun pmltransform_i0prog (i0prog: i0prog): pml_spec









