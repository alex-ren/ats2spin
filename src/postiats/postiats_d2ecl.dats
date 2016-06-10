(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
//
(* ****** ****** *)

staload "./postiats.sats"

(* ****** ****** *)

#include "./postiats_codegen2.hats"

(* ****** ****** *)


extern
fun fprint_i2mpdec (FILEref, i2mpdec): void

(* ****** ****** *)

extern
fun fprint_f2undec (FILEref, f2undec): void
extern
fun fprint_f2undeclst (FILEref, f2undeclst): void

extern
fun fprint_v2aldec (FILEref, v2aldec): void
extern
fun fprint_v2ardec (FILEref, v2ardec): void
extern
fun fprint_v2aldeclst (FILEref, v2aldeclst): void

extern
fun fprint_v2ardeclst (FILEref, v2ardeclst): void

(* ****** ****** *)

implement fprint_val<d2ecl> = fprint_d2ecl
implement fprint_val<i2mpdec> = fprint_i2mpdec
implement fprint_val<funkind> = fprint_funkind
implement fprint_val<valkind> = fprint_valkind
implement fprint_val<casekind> = fprint_casekind
implement fprint_val<d2cst> = fprint_d2cst

implement fprint_val<f2undec> = fprint_f2undec
implement fprint_val<v2aldec> = fprint_v2aldec
implement fprint_val<v2ardec> = fprint_v2ardec

implement fprint_val<f2undeclst> = fprint_f2undeclst
implement fprint_val<v2aldeclst> = fprint_v2aldeclst
implement fprint_val<v2ardeclst> (out, xs) = fprint_v2ardeclst (out, xs)
implement fprint_val<d2eclist> = fprint_d2eclist

// todo
// Has to overload the implementation to 
// add the annotation for template argument, e.g.
// f2undeclst in this example.
implement{}
fprint_d2ecl_node$D2Cfundecs$arg2(out, arg0) =
  let val-D2Cfundecs(_, arg2) = arg0 in fprint_d2ecl_node$carg<f2undeclst>(out, arg2) end


implement{}
fprint_d2ecl_node$D2Cvaldecs$arg2(out, arg0) =
  let val-D2Cvaldecs(_, arg2) = arg0 in fprint_d2ecl_node$carg<v2aldeclst>(out, arg2) end

implement{}
fprint_d2ecl_node$D2Cvardecs$arg1(out, arg0) =
  let val-D2Cvardecs(arg1) = arg0 in fprint_d2ecl_node$carg<v2ardeclst>(out, arg1) end

implement{}
fprint_d2ecl_node$D2Clocal$arg1(out, arg0) =
  let val-D2Clocal(arg1, _) = arg0 in fprint_d2ecl_node$carg<d2eclist>(out, arg1) end

implement{}
fprint_d2ecl_node$D2Clocal$arg2(out, arg0) =
  let val-D2Clocal(_, arg2) = arg0 in fprint_d2ecl_node$carg<d2eclist>(out, arg2) end

(* ****** ****** *)

// for pretty print

implement{}
fprint_d2ecl_node$D2Cfundecs$lpar(out, _) = fprint (out, "(\n")

implement{}
fprint_d2ecl_node$D2Cfundecs$rpar(out, _) = fprint (out, "\n)")

(* ****** ****** *)

implement
fprint_i2mpdec
  (out, imp) =
{
  val () =
    fprint! (out, "i2mpdec{")
  val () = fprint! (out, "d2c= ", imp.i2mpdec_cst)
  val () = fprint! (out, "; ")
  val () = fprint! (out, "def= ", imp.i2mpdec_def)
  val () = fprint! (out, "}")
} (* end of [fprint_i2mpdec] *)

(* ****** ****** *)

implement
fprint_f2undec
  (out, f2d) =
{
  val () =
    fprint! (out, "f2undec{")
  val () = fprint! (out, "d2v= ", f2d.f2undec_var)
  val () = fprint! (out, "; ")
  val () = fprint! (out, "def= ", f2d.f2undec_def)
  val () = fprint! (out, "}")
} (* end of [fprint_f2undec] *)

(* ****** ****** *)

implement
fprint_f2undeclst
  (out, f2ds) = let
implement
fprint_list$sep<> (out) = fprint_string (out, ",\n")
//
in
  fprint_list<f2undec> (out, f2ds)
end // end of [fprint_f2undeclst]

(* ****** ****** *)

implement
fprint_v2aldec
  (out, v2d) =
{
  val () =
    fprint! (out, "v2aldec{")
  val () = fprint! (out, "pat= ", v2d.v2aldec_pat)
  val () = fprint! (out, "; ")
  val () = fprint! (out, "def= ", v2d.v2aldec_def)
  val () = fprint! (out, "}")
} (* end of [fprint_v2aldec] *)

(* ****** ****** *)

implement
fprint_v2ardec
  (out, v2d) =
{
  val () =
    fprint! (out, "v2ardec{")
  val () = fprint! (out, "name= ", v2d.v2ardec_name)
  val () = fprint! (out, "; ")
  val () = (case+ v2d.v2ardec_init of
           | Some init => fprint! (out, "init= ", init)
           | None () => fprint! (out, "uninitialized")
           ): void
  val () = fprint! (out, "}")
} (* end of [fprint_v2ardec] *)

(* ****** ****** *)

implement
fprint_v2aldeclst
  (out, v2ds) = let
implement
fprint_list$sep<> (out) = fprint_string (out, ",\n")
//
in
  fprint_list<v2aldec> (out, v2ds)
end // end of [fprint_v2aldeclst]


(* ****** ****** *)

implement
fprint_v2ardeclst
  (out, v2ds) = let
implement
fprint_list$sep<> (out) = fprint_string (out, ",\n")
//
in
  fprint_list<v2ardec> (out, v2ds)
end // end of [fprint_v2ardeclst]

(* ****** ****** *)

implement
myfprint_d2ecl_node (out, node) = fprint_d2ecl_node<> (out, node)

(* ****** ****** *)

implement
fprint_d2ecl
  (out, d2c0) = let
in
  myfprint_d2ecl_node (out, d2c0.d2ecl_node)
end

(* ****** ****** *)

implement
fprint_d2eclist
  (out, d2cs) = let
//
implement
fprint_list$sep<> (out) = fprint_string (out, ",\n")
//
in
  fprint_list<d2ecl> (out, d2cs)
end // end of [fprint_d2eclist]


(* ****** ****** *)


implement
i2mpdec_make
(
  loc, locid, d2c, d2e
) = '{
  i2mpdec_loc= loc
, i2mpdec_locid= locid
, i2mpdec_cst= d2c
, i2mpdec_def= d2e
} (* end of [i2mpdec_make] *)

(* ****** ****** *)

implement
f2undec_make
  (loc, d2v, d2e) = '{
  f2undec_loc= loc
, f2undec_var= d2v
, f2undec_def= d2e
} (* end of [f2undec_make] *)

(* ****** ****** *)

implement
v2aldec_make
  (loc, p2t, d2e) = '{
  v2aldec_loc= loc
, v2aldec_pat= p2t
, v2aldec_def= d2e
} (* end of [v2aldec_make] *)


implement
v2ardec_make
  (loc, name, init) = '{
  v2ardec_loc= loc
, v2ardec_name= name
, v2ardec_init= init
} (* end of [v2ardec_make] *)

(* ****** ****** *)

implement
d2ecl_make_node
  (loc, node) = '{
  d2ecl_loc= loc, d2ecl_node= node
} (* end of [d2ecl_make_node] *)

(* ****** ****** *)
//
implement
d2ecl_fundeclst
  (loc, knd, f2ds) =
  d2ecl_make_node (loc, D2Cfundecs (knd, f2ds))
//
(* ****** ****** *)
//
implement
d2ecl_valdeclst
  (loc, knd, v2ds) =
  d2ecl_make_node (loc, D2Cvaldecs (knd, v2ds))
//
(* ****** ****** *)

implement
d2ecl_local
  (loc, head, body) =
  d2ecl_make_node (loc, D2Clocal (head, body))

(* ****** ****** *)

implement
d2ecl_ignored (loc) = d2ecl_make_node (loc, D2Cignored())

(* ****** ****** *)

(* end of [postiats_d2ecl.dats] *)


