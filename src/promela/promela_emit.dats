
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/emiter.sats"

staload "./../utils/utils.dats"
staload "./../utils/emiter.dats"
staload "./../postiats/utfpl.sats"

(* ************ ************* *)

staload "./promela.sats"

(* ************ ************* *)

extern fun emit_pml_module (pml_module): eu
extern fun emit_pml_init (pml_steplst): eu
extern fun emit_pml_proctype (pml_proctype): eu
extern fun emit_pml_inline (pml_inline): eu
extern fun emit_pml_decl (pml_decl): eu
extern fun emit_pml_name (pml_name): eu
extern fun emit_pml_step (pml_step): eu
extern fun emit_pml_type (pml_type): eu
extern fun emit_pml_ivar (pml_ivar): eu
extern fun emit_pml_exp (pml_exp): eu
extern fun emit_pml_anyexp (pml_anyexp): eu
extern fun emit_pml_varref (pml_varref): eu
extern fun emit_pml_anyexp_fcall (string, pml_anyexplst): eu
extern fun emit_pml_anyexp_inline (pml_name, pml_anyexplst): eu
extern fun emit_pml_stmnt (pml_stmnt): eu
extern fun emit_pml_opr (pml_opr): eu
extern fun emit_pml_atom (pml_atom): eu

(* ************ ************* *)

implement emit_val<pml_module> (module) =
  emit_pml_module (module)


implement emit_val<pml_decl> (decl) =
  emit_pml_decl (decl)

implement emit_val<pml_step> (step) =
  emit_pml_step (step)

implement emit_val<pml_ivar> (ivar) =
  emit_pml_ivar (ivar)

implement emit_val<pml_anyexp> (anyexp) =
  emit_pml_anyexp (anyexp)

implement emit_val<pml_name> (name) =
  emit_pml_name (name)

(* ************ ************* *)

implement emit_pml_program (program) = 
  EUlist (emit<pml_module> (program, emit_newline ()))

implement emit_pml_module (pml_module) =
case+ pml_module of
| PMLMODULE_utype _ => exitlocmsg ("not supported")
| PMLMODULE_mtype _ => exitlocmsg ("not supported")
| PMLMODULE_declst _ => exitlocmsg ("not supported")
| PMLMODULE_proctype proctype => 
    emit_pml_proctype (proctype)
| PMLMODULE_inline inline => emit_pml_inline (inline)
| PMLMODULE_init pml_steplst =>
    emit_pml_init (pml_steplst)
| PMLMODULE_never _ => exitlocmsg ("not supported")
| PMLMODULE_c_code _ => exitlocmsg ("not supported")
| PMLMODULE_literal_code code => emit code

implement emit_pml_init (pml_steplst) = let
  #define steps pml_steplst
  val eus = emit ("init {")
  :: emit_indent ()
  :: emit_newline ()
  :: EUlist (
     emit<pml_step> (pml_steplst,
         EUlist ((emit ";") :: (emit_newline ()) :: nil0)))
  :: emit_unindent ()
  :: emit_newline ()
  :: emit ("}")
  :: nil0
in
  EUlist (eus)
end

implement emit_pml_proctype (pml_proctype) = let
  #define proc pml_proctype
  val eus = 
    emit_text ("proctype ")
    :: emit_pml_name (proc.pml_proctype_name)
    :: emit_text ("(")
    :: EUlist (
       emit<pml_decl> (proc.pml_proctype_paralst, emit_text ("; ")))
    :: emit_text (")")
    :: emit_text (" {")
    :: emit_indent ()
    :: emit_newline ()
    :: EUlist (
       emit<pml_step> (proc.pml_proctype_seq,
           EUlist ((emit ";") :: (emit_newline ()) :: nil0)))
    :: emit_unindent ()
    :: emit_newline ()
    :: emit_text ("}") :: nil0
in
  EUlist (eus)
end

implement emit_pml_inline (pml_inline) = let
  #define inline pml_inline
  val eus = 
    emit_text ("inline ")
    :: emit_pml_name (inline.pml_inline_name)
    :: emit_text ("(")
    :: EUlist (
       emit<pml_name> (inline.pml_inline_paralst, emit_text (", ")))
    :: emit_text (")")
    :: emit_text (" {")
    :: emit_indent ()
    :: emit_newline ()
    :: EUlist (
       emit<pml_step> (inline.pml_inline_seq,
           EUlist ((emit ";") :: (emit_newline ()) :: nil0)))
    :: emit_unindent ()
    :: emit_newline ()
    :: emit_text ("}") :: nil0
in
  EUlist (eus)
end
implement emit_pml_name (pml_name) = let
  val name = pml_name_get_name (pml_name)
in
  emit_text (name)
end

implement emit_pml_decl (pml_decl) = let
  #define dec pml_decl
  val eus = 
    emit_pml_type (dec.pml_decl_type)
    :: emit_text (" ")
    :: EUlist (emit<pml_ivar> (dec.pml_decl_ivarlst, emit_text (", ")))
    :: nil0
in
  EUlist (eus)
end
   
implement emit_pml_ivar (pml_ivar) = let
  #define ivar pml_ivar
in
case+ ivar of
| PMLIVAR_exp (pml_name (* bool (is constant)*), pml_exp) => let
    val eus =
      emit_pml_name (pml_name) 
      :: emit_text (" = ")
      :: emit_pml_exp (pml_exp)
      :: nil0
in
  EUlist (eus)
end
| PMLIVAR_chan (pml_name (* bool (is constant)*), pml_chan_init) =>
    exitlocmsg ("not supported")
| PMLIVAR_name (pml_name) => emit_pml_name (pml_name)
end

implement emit_pml_step (pml_step) = let
  #define step pml_step
in
case+ step of
| PMLSTEP_declst (pml_declst) =>
  EUlist (emit<pml_decl> (pml_declst, 
    EUlist (emit (";") :: emit_newline () :: nil0)))
| PMLSTEP_stmnt (pml_stmnt) => emit_pml_stmnt (pml_stmnt)
// | PMLSTEP_xr of (list0 varref) (* read only *)
// | PMLSTEP_xs of (list0 varref) (* write only *)
end

implement emit_pml_type (pml_type) =
case+ pml_type of
| PMLTYPE_bit () => exitlocmsg ("not supported")
| PMLTYPE_bool () => exitlocmsg ("not supported")
| PMLTYPE_byte () => exitlocmsg ("not supported")
| PMLTYPE_pid () => exitlocmsg ("not supported")
| PMLTYPE_short () => exitlocmsg ("not supported")
| PMLTYPE_int () => exitlocmsg ("not supported")
| PMLTYPE_mtype () => exitlocmsg ("not supported")
| PMLTYPE_chan () => exitlocmsg ("not supported")
| PMLTYPE_uname pml_uname => exitlocmsg ("not supported")
| PMLTYPE_todo () => emit_text ("int")

implement emit_pml_stmnt (pml_stmnt) = let
  #define st pml_stmnt
in
case+ st of
| PMLSTMNT_if pml_options => let
  val eus = emit ("fi") :: nil0
  val eus = list0_foldright (pml_options, fopr, eus) where {
    fun fopr (pml_steplst: pml_steplst, res: eulst):<cloref1> eulst = 
    case+ pml_steplst of
    | step1 :: steps => let
      val eu1 = emit_pml_step (step1)
      val eus_rest = emit<pml_step> (steps
                      , EUlist (emit ";" :: emit_newline () :: nil0))
      val eus_option = emit ":: " :: eu1 :: emit " -> " 
        :: emit_indent () :: emit_newline ()
        :: EUlist (eus_rest) :: emit_unindent () :: emit_newline () :: nil0
      val eu = EUlist (eus_option) 
    in
      eu :: res
    end
    | nil0 () => EUlist (nil0) :: res
  }
  val eus = emit "if " :: emit_newline () :: eus
in 
  EUlist eus 
end
| PMLSTMNT_do pml_options => exitlocmsg ("not supported")
| PMLSTMNT_atomic pml_steplst => exitlocmsg ("not supported")
| PMLSTMNT_dstep pml_steplst => exitlocmsg ("not supported")
| PMLSTMNT_block pml_steplst  (* { xxx } *) => exitlocmsg ("not supported")
// | PMLSTMNT_send   // todo
// | PMLSTMNT_receive
| PMLSTMNT_assign (pml_varref, pml_anyexp) => let
  val eus = emit_pml_varref (pml_varref)
    :: emit " = "
    :: emit_pml_anyexp (pml_anyexp)
    :: nil0
in
  EUlist (eus)
end
| PMLSTMNT_else () => emit "else "
| PMLSTMNT_break () => exitlocmsg ("not supported")
| PMLSTMNT_goto pml_name => let
  val eus = emit "goto "
    :: emit_pml_name (pml_name)
    :: nil0
in
  EUlist (eus)
end
| PMLSTMNT_name (pml_name, pml_stmnt) => let
  val eus = emit_pml_name (pml_name)
    :: emit ":"
    :: emit_newline ()
    :: emit_pml_stmnt (pml_stmnt)
    :: nil0
in
  EUlist (eus)
end
// | PMLSTMNT_print
| PMLSTMNT_assert pml_exp => exitlocmsg ("not supported")
| PMLSTMNT_exp pml_exp => emit_pml_exp (pml_exp)
// Inline call
| PMLSTMNT_inline (pml_name, pml_anyexplst) => 
    exitlocmsg ("not supported")
// | PMLSTMNT_c_code
// | PMLSTMNT_c_expr
end

implement emit_pml_exp (pml_exp) =
case+ pml_exp of
| PMLEXP_anyexp (pml_anyexp) => emit_pml_anyexp (pml_anyexp)
| PMLEXP_chanop (pml_varref) => exitlocmsg ("not supported")

implement emit_pml_anyexp (pml_anyexp) = 
case+ pml_anyexp of
| PMLANYEXP_binarop (opr, any_exp1, any_exp2) => let
  val eus = emit_text ("(")
    :: emit_pml_anyexp (any_exp1)
    :: emit_text (")")
    :: emit_text (" ")
    :: emit_pml_opr (opr)
    :: emit_text (" ")
    :: emit_text ("(")
    :: emit_pml_anyexp (any_exp2)
    :: emit_text (")")
    :: nil0
in
  EUlist (eus)
end
| PMLANYEXP_unarop (pml_opr, pml_anyexp) => let
  val eus = emit_pml_opr (pml_opr)
    :: emit_text ("(")
    :: emit_pml_anyexp (pml_anyexp)
    :: emit_text (")")
    :: nil0
in
  EUlist (eus)
end
// x -> a : b
| PMLANYEXP_select (pml_anyexp, pml_anyexp, pml_anyexp)
  => exitlocmsg ("not supported")
// | PMLANYEXP_len
// | PMLANYEXP_recv_poll
| PMLANYEXP_varref pml_varref  // e.g. arr[2]
  => emit_pml_varref (pml_varref)
| PMLANYEXP_const pml_atom
  => emit_pml_atom (pml_atom)
| PMLANYEXP_fcall (name, pml_anyexplst) => 
    emit_pml_anyexp_fcall (name, pml_anyexplst)
| PMLANYEXP_string (str) => emit_text ("\"" + str + "\"")
// | PMLANYEXP_timeout
// | PMLANYEXP_np (* non-progress system state *)
// | PMLANYEXP_enabled (pml_anyexp)
// | PMLANYEXP_pc_value (pml_anyexp)
// | PMLANYEXP_name (pml_name, pml_anyexp, pml_name)
| PMLANYEXP_run (pml_name, pml_arglst (*pml_priority_opt*)) => let
  val eus = emit ("run ")
    :: emit_pml_name (pml_name)
    :: emit ("(")
    :: EUlist (emit<pml_anyexp> (pml_arglst, emit (", ")))
    :: emit (")")
    :: nil0
in
  EUlist (eus)
end

| PMLANYEXP_inline (pml_name, pml_anyexplst (*pml_priority_opt*)) =>
    emit_pml_anyexp_inline (pml_name, pml_anyexplst)


implement emit_pml_opr (pml_opr) =
case+ pml_opr of
| PMLOPR_plus () => emit_text ("+")
| PMLOPR_minus () => emit_text ("-")
| PMLOPR_mul () => emit_text ("*")
| PMLOPR_div () => emit_text ("/")
| PMLOPR_gt () => emit_text (">")
| PMLOPR_gte () => emit_text (">=")
| PMLOPR_lt () => emit_text ("<")
| PMLOPR_lte () => emit_text ("<=")
| PMLOPR_and () => emit_text ("&&")
| PMLOPR_or () => emit_text ("||")
| PMLOPR_eq () => emit_text ("==")
| PMLOPR_neg () => emit_text ("~")
| PMLOPR_ban () => emit_text ("!")

implement emit_pml_varref (pml_varref) = let
  val+ PMLVARREF (pml_name, pml_anyexp_opt, pml_varref_opt) = pml_varref
  val eu_name = emit_pml_name (pml_name)
in
  case+ pml_anyexp_opt of
  | Some0 (pml_anyexp) => let
    val eu_anyexp = emit_pml_anyexp (pml_anyexp)
  in
    case+ pml_varref_opt of
    | Some0 (pml_varref) => exitlocmsg ("not supported")
    | None0 () => let
      val eus = 
        eu_name
        :: emit_text ("[")
        :: eu_anyexp
        :: emit_text ("]")
        :: nil0
    in
      EUlist (eus)
    end
  end
  | None0 () => eu_name
end

implement emit_pml_atom (pml_atom) =
case+ pml_atom of
| PMLATOM_int (n) => emit (n)
| PMLATOM_i0nt (n_str) => emit (n_str)
| PMLATOM_bool (b) => emit (b)
| PMLATOM_char (c) => emit c

implement emit_pml_anyexp_fcall (name, pml_anyexplst) = let
  val eus = emit_text (name)
  :: emit_text ("(")
  :: EUlist (emit<pml_anyexp> (pml_anyexplst, emit_text (", ")))
  :: emit_text (")")
  :: nil0
in
  EUlist (eus)
end

implement emit_pml_anyexp_inline (pml_name, pml_anyexplst) = let
  val eus = emit_pml_name (pml_name)
  :: emit_text ("(")
  :: EUlist (emit<pml_anyexp> (pml_anyexplst, emit_text (", ")))
  :: emit_text (")")
  :: nil0
in
  EUlist (eus)
end





