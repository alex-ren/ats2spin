
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/emiter.sats"

staload "./../utils/utils.dats"
staload "./../utils/emiter.dats"

(* ************ ************* *)

staload "./promela.sats"

(* ************ ************* *)

extern fun emit_pml_module (pml_module): eu

(* ************ ************* *)

implement emit_val<pml_module> (module) =
  emit_pml_module (module)

(* ************ ************* *)

implement emit_pml_program (program) = 
  EUlist (emit<pml_module> (program, emit_newline ()))

implement emit_pml_module (pml_module) =
  emit_text ("... module ...")

