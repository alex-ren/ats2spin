
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
extern fun emit_pml_proctype (pml_proctype): eu
extern fun emit_pml_decl (pml_decl): eu
extern fun emit_pml_name (pml_name): eu
extern fun emit_pml_step (pml_step): eu

(* ************ ************* *)

implement emit_val<pml_module> (module) =
  emit_pml_module (module)


implement emit_val<pml_decl> (decl) =
  emit_pml_decl (decl)

implement emit_val<pml_step> (step) =
  emit_pml_step (step)

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
| PMLMODULE_inline _ => exitlocmsg ("not supported")
| PMLMODULE_init _ => exitlocmsg ("not supported")
| PMLMODULE_never _ => exitlocmsg ("not supported")
| PMLMODULE_c_code _ => exitlocmsg ("not supported")

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
       emit<pml_step> (proc.pml_proctype_seq, emit_newline ()))
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
  #define pml_decl = dec
  val eus = 
    emit_pml_type (pml_decl.pml_decl_type) ::
    :: emit_text (
   

////
typedef pml_decl = '{
  pml_decl_visible = bool
  , pml_decl_type = pml_type
  , pml_decl_ivarlst = pml_ivarlst
}
