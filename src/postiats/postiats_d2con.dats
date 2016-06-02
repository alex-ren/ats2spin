
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
eq_d2con_d2con
  (d2c1, d2c2) = compare (d2c1, d2c2) = 0
implement
neq_d2con_d2con
  (d2c1, d2c2) = compare (d2c1, d2c2) != 0
//
(* ****** ****** *)

typedef
d2con_struct = @{
  d2con_name= symbol
, d2con_stamp= stamp
, d2con_type = s2exp
} (* end of [d2con_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume d2con_type = ref (d2con_struct)
//
in (* in of [local] *)


implement
d2con_make
  (sym, s2exp, stamp) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<d2con_struct> ()
//
val () = p->d2con_name := sym
val () = p->d2con_type := s2exp
val () = p->d2con_stamp := stamp
//
in
  $UN.castvwtp0{d2con}((pfat, pfgc | p))
end // end of [d2con_make]

implement
d2con_get_name
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->d2con_name
end // end of [let]
) (* end of [d2con_get_name] *)

implement d2con_get_type 
(d2con) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2con)
in
  p->d2con_type
end // end of [let]
) (* end of [d2con_get_name] *)



implement
d2con_get_stamp
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->d2con_stamp
end // end of [let]
) (* end of [d2con_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_d2con
  (out, d2c) =
(
  fprint! (out, d2c.name(), "(", d2c.stamp(), ")")
) (* end of [fprint_d2con] *)

(* ****** ****** *)

implement
compare_d2con_d2con
  (d2c1, d2c2) = compare (d2c1.stamp(), d2c2.stamp())
// end of [compare_d2con_d2con]

(* ****** ****** *)

(* end of [postiats_d2con.dats] *)

