
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "libats/ML/SATS/list0.sats"

staload "./instr0.sats"

staload "./../utils/utils.sats"

// staload _ = "./../utils/print_infrastructure.dats"
staload _(*anon*) = "./instr0.dats"
staload _(*anon*) = "./i0ins.dats"

staload _(*anon*) = "libats/ML/DATS/list0.dats"

assume i0fundef = '{
  i0fundef_name = i0id
  , i0fundef_paralst = i0idlst
  , i0fundef_inss = i0inslst
  // Names for the functions in the same group,
  // including self. This is nil if the function
  // is not (mutually) tail recursive.
  , i0fundef_group = i0idlst
}

implement i0fundef_get_id (f) = f.i0fundef_name
implement i0fundef_get_group (f) = f.i0fundef_group
implement i0fundef_get_instructions (f) = f.i0fundef_inss
implement i0fundef_get_paralst (f) = f.i0fundef_paralst
implement i0fundef_is_recursive (f) = 
  ~list0_is_empty (i0fundef_get_group (f))


implement i0fundef_create (
  name
  , paralst
  , inss
  , group
  ) = '{
  i0fundef_name = name
  , i0fundef_paralst = paralst
  , i0fundef_inss = inss
  , i0fundef_group = group
  }

// implement fprint_val<i0fundef> = fprint_i0fundef

implement fprint_i0fundef (out, i0fundef) = let
  val () = fprint (out, "// group contains (")
  val () = fprint_list0<i0id> (out, i0fundef.i0fundef_group)
  val () = fprint (out, ")\n")
  val () = fprint (out, "fun ")
  val () = fprint (out, i0fundef.i0fundef_name)
  val () = fprint (out, "(")
  val () = fprint_list0<i0id> (out, i0fundef.i0fundef_paralst)
  val () = fprint (out, ")")
  val () = fprint (out, " {\n")
  val () = fprint_list0_sep (out, i0fundef.i0fundef_inss, "\n")
  val () = fprint (out, "\n}")
in
end


