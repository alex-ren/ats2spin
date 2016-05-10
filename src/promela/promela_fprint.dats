
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../instr0/instr0.sats"

#include "./../instr0/instr0_codegen2.hats"
#include "./promela_codegen2.hats"

staload _ = "./pml_name.dats"

(* ************ ************* *)

implement fprint_val<pml_decl> (out, pml_decl) = 
  fprint_pml_decl (out, pml_decl)

implement fprint_val<pml_modulelst> (out, program) = 
  fprint_pml_program (out, program)

implement
  fprint_val<pml_module> (out, module) = myfprint_pml_module (out, module)

implement fprint_val<pml_proctype> (out, proctype) = 
  fprint_pml_proctype (out, proctype)

implement fprint_val<pml_inline> (out, inline) = 
  fprint_pml_inline (out, inline)

implement fprint_val<pml_uname> (out, uname) = 
  fprint_pml_uname (out, uname)

implement fprint_val<pml_ivar> (out, ivar) = 
  myfprint_pml_ivar (out, ivar)

implement fprint_val<pml_exp> (out, exp) =
  myfprint_pml_exp (out, exp)
  
implement fprint_val<pml_chan_init> (out, chan_init) =
  fprint_pml_chan_init (out, chan_init)

implement fprint_val<pml_anyexp> (out, anyexp) =
  myfprint_pml_anyexp (out, anyexp)

implement fprint_val<pml_varref> (out, varref) =
  myfprint_pml_varref (out, varref)

implement fprint_val<pml_opr> (out, opr) =
  fprint_pml_opr (out, opr)

implement fprint_val<pml_atom> (out, atom) =
  fprint_pml_atom (out, atom)

implement fprint_val<pml_step> (out, step) =
  myfprint_pml_step (out, step)
  
implement fprint_val<pml_stmnt> (out, stmnt) =
  myfprint_pml_stmnt (out, stmnt)

(* ************ ************* *)

implement myfprint_pml_module (out, module) =
  fprint_pml_module (out, module)

implement fprint_pml_program (out, pml_modulelst) = let
  val () = fprint_list0_sep (out, pml_modulelst, "\n\n")
in end

implement fprint_pml_decl (out, pml_decl) = let
  val () = fprint_pml_type (out, pml_decl.pml_decl_type)
  val () = fprint (out, " ")
  val () = fprint_list0_sep (out, pml_decl.pml_decl_ivarlst, ", ")
in end

implement fprint_pml_proctype (out, proctype) = let
  val () = fprint (out, "proctype ")
  val () = fprint_pml_name (out, proctype.pml_proctype_name)
  val () = fprint (out, "(")
  val () = fprint_pml_declst (out, proctype.pml_proctype_paralst)
  val () = fprint (out, ") {\n")
  val () = fprint (out, proctype.pml_proctype_seq, "\n")
  val () = fprint (out, "\n}\n")
in end

implement fprint_pml_inline (out, inline) = let
  val () = fprint (out, "inline ")
  val () = fprint_pml_name (out, inline.pml_inline_name)
  val () = fprint (out, "(")
  val () = fprint (out, inline.pml_inline_paralst)
  val () = fprint (out, ")")
  val () = fprint (out, "\n")
  val () = fprint (out, "todo: fprint_pml_inline")
in end

implement myfprint_pml_ivar (out, pml_ivar) = 
  fprint_pml_ivar (out, pml_ivar)

implement fprint_pml_chan_init (out, pml_chan_init) = let
  val () = fprint (out, "chan_init todo")
in end

implement fprint_pml_declst (out, declst) = let
  val () = fprint (out, declst, "; ")
in end

implement myfprint_pml_exp (out, exp) = let
  val () = fprint_pml_exp<> (out, exp)
in end

implement myfprint_pml_anyexp (out, anyexp) = let
  val () = fprint_pml_anyexp<> (out, anyexp)
in end

implement myfprint_pml_varref (out, varref) = let
  val () = fprint_pml_varref<> (out, varref)
in end

implement fprint_pml_opr (out, opr) =
case+ opr of
| PMLOPR_plus ()  => fprint (out, "+")
| PMLOPR_minus () => fprint (out, "-")
| PMLOPR_and ()   => fprint (out, "*")
| PMLOPR_or ()    => fprint (out, "/")
| PMLOPR_neg ()   => fprint (out, "~")
| PMLOPR_ban ()   => fprint (out, "!")

implement fprint_pml_atom (out, atom) =
case+ atom of
| PMLATOM_int (x)  => fprint (out, x)
| PMLATOM_i0nt (str)  => fprint (out, str)
| PMLATOM_bool (x) => fprint (out, x)
| PMLATOM_char (x) => fprint (out, x)


implement myfprint_pml_step (out, step) = let
  val () = fprint_pml_step<> (out, step)
in end

implement myfprint_pml_stmnt (out, stmnt) = let
  val () = fprint_pml_stmnt<> (out, stmnt)
in end


