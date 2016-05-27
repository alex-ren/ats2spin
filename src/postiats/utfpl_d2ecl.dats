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

staload "./utfpl.sats"

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
implement fprint_val<valkind> = fprint_funkind
implement fprint_val<casekind> = fprint_funkind

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
in
//
case+ f2ds of
| list_cons
    (f2d, f2ds) => let
    val () =
      fprint_f2undec (out, f2d)
    val () = fprint_newline (out)
  in
    fprint_f2undeclst (out, f2ds)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
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
in
//
case+ v2ds of
| list_cons
    (v2d, v2ds) => let
    val () =
      fprint_v2aldec (out, v2d)
    val () = fprint_newline (out)
  in
    fprint_v2aldeclst (out, v2ds)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [fprint_v2aldeclst]

(* ****** ****** *)

implement
fprint_v2ardeclst
  (out, v2ds) = let
in
//
case+ v2ds of
| list_cons
    (v2d, v2ds) => let
    val () =
      fprint_v2ardec (out, v2d)
    val () = fprint_newline (out)
  in
    fprint_v2ardeclst (out, v2ds)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [fprint_v2ardeclst]

(* ****** ****** *)
implement
fprint_d2ecl
  (out, d2c0) = let
in
  myfprint_d2ecl_node (out, d2c0.d2ecl_node)
end

// //
// case+ d2c0.d2ecl_node of
// //
// | D2Cimpdec
//     (knd, imp) =>
//   {
//     val () =
//       fprint! (out, "D2Cimpdec(\n")
//     val () = fprint_i2mpdec (out, imp)
//     val () = fprint! (out, "\n)")
//   }
// //
// | D2Cfundecs
//     (knd, f2ds) =>
//   {
//     val () =
//       fprint! (out, "D2Cfundecs(\n")
//     val () = fprint_f2undeclst (out, f2ds)
//     val () = fprint! (out, ")")
//   }
// //
// | D2Cvaldecs
//     (knd, v2ds) =>
//   {
//     val () =
//       fprint! (out, "D2Cvaldecs(\n")
//     val () = fprint_v2aldeclst (out, v2ds)
//     val () = fprint! (out, ")")
//   }
// //
// | D2Cvardecs
//     (v2ds) =>
//   {
//     val () =
//       fprint! (out, "D2Cvardecs(\n")
//     val () = fprint_v2ardeclst (out, v2ds)
//     val () = fprint! (out, ")")
//   }
// //
// | D2Cdcstdecs (knd, d2cst) =>
//   {
//     val () =
//       fprint! (out, "D2Cdcstdecs(\n")
//     val () = fprint_d2cst (out, d2cst)
//     val () = fprint! (out, ")")
//   }
// | D2Clocal
//     (head, body) =>
//   {
//     val () =
//       fprint! (out, "D2Clocal(\n")
//     val () = fprint_d2eclist (out, head)
//     val () = fprint! (out, ")in-of-local(\n")
//     val () = fprint_d2eclist (out, body)
//     val () = fprint! (out, ")end-of-local\n")
//   }
// | D2Cextcode (code) => let
//     val () = fprint! (out, "D2Cextcode(\n")
//     val () = fprint! (out, code)
//     val () = fprint! (out, ")\n")
// in end
// //
// | D2Cignored((*void*)) => fprint! (out, "D2Cignored(", ")\n")
// //
// (*
// | _ (*temporary*) => fprint! (out, "D2C...(", "...", ")")
// *)
// //
// end // end of [fprint_d2ecl]

(* ****** ****** *)

implement
fprint_d2eclist
  (out, d2cs) = let
//
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
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

implement
myfprint_d2ecl_node (out, node) = fprint_d2ecl_node<> (out, node)

(* ****** ****** *)

(* end of [utfpl_d2ecl.dats] *)
