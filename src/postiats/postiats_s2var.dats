

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

(* ************ ************* *)

//
(* ****** ****** *)

staload "./postiats.sats"

(* ****** ****** *)
//
implement
eq_s2var_s2var
  (d2c1, d2c2) = compare (d2c1, d2c2) = 0
implement
neq_s2var_s2var
  (d2c1, d2c2) = compare (d2c1, d2c2) != 0
//
(* ****** ****** *)

typedef
s2var_struct = @{
  s2var_name= symbol
, s2var_stamp= stamp
, s2var_sort = s2rt
} (* end of [s2var_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume s2var_type = ref (s2var_struct)
//
in (* in of [local] *)


implement
s2var_make
  (name, stamp, s2rt) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<s2var_struct> ()
//
val () = p->s2var_name := name
val () = p->s2var_stamp := stamp
val () = p->s2var_sort := s2rt
//
in
  $UN.castvwtp0{s2var}((pfat, pfgc | p))
end // end of [s2var_make]

implement
s2var_get_name
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->s2var_name
end // end of [let]
) (* end of [s2var_get_name] *)

implement s2var_get_sort 
(s2var) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2var)
in
  p->s2var_sort
end // end of [let]
) (* end of [s2var_get_name] *)



implement
s2var_get_stamp
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->s2var_stamp
end // end of [let]
) (* end of [s2var_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_s2var
  (out, d2c) =
(
  fprint! (out, d2c.name(), "(", d2c.stamp(), ")")
) (* end of [fprint_s2var] *)

(* ****** ****** *)

implement
compare_s2var_s2var
  (d2c1, d2c2) = compare (d2c1.stamp(), d2c2.stamp())
// end of [compare_s2var_s2var]

(* ****** ****** *)

(* end of [postiats_s2var.dats] *)

