
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/emiter.sats"

staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"

implement emit_pml_program (program) = l

