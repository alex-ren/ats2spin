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

implement fprint_val<d2var> = fprint_d2var

implement fprint_val<labp2atlst> = fprint_labp2atlst
implement fprint_val<p2atlst> = fprint_p2atlst
implement fprint_val<p2at> = fprint_p2at
implement fprint_val<s2exp> = fprint_s2exp
implement fprint_val<d2con> = fprint_d2con

implement{}
fprint_p2at_node$P2Trec$arg3(out, arg0) =
  let val-P2Trec(_, _, arg1) = arg0 
in fprint_p2at_node$carg<labp2atlst>(out, arg1) end

implement{}
fprint_p2at_node$P2Tcon$arg3(out, arg0) =
  let val-P2Tcon(_, _, arg1) = arg0 
in fprint_p2at_node$carg<p2atlst>(out, arg1) end

(* ****** ****** *)

implement
myfprint_p2at_node (out, node) = fprint_p2at_node<> (out, node)

implement
fprint_p2at
  (out, p2t0) = let
in
  myfprint_p2at_node (out, p2t0.p2at_node)
end

(* ****** ****** *)

implement
fprint_p2atlst
  (out, p2ts) = let
//
implement
fprint_val<p2at> = fprint_p2at
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<p2at> (out, p2ts)
end // end of [fprint_p2atlst]

(* ****** ****** *)

implement
fprint_labp2at
  (out, lp2t) = let
in
//
case+ lp2t of
| LABP2ATnorm
    (lab, p2t) =>
  (
    fprint! (
      out, "LABP2ATnorm(", lab, "->", p2t, ")"
    ) (* end of [fprint!] *)
  )
| LABP2ATomit () => fprint (out, "LABP2ATomit()")
//
end // end of [fprint_labp2at]

(* ****** ****** *)

implement
fprint_labp2atlst
  (out, lp2ts) = let
//
implement
fprint_val<labp2at> = fprint_labp2at
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<labp2at> (out, lp2ts)
end // end of [fprint_labp2atlst]

(* ****** ****** *)

implement
p2at_make_node
  (loc, node) = '{
  p2at_loc= loc, p2at_node= node
} (* end of [p2at_make_node] *)

(* ****** ****** *)
//
implement
p2at_var (loc, d2v) =
  p2at_make_node (loc, P2Tvar (d2v))
//
(* ****** ****** *)

implement
p2at_rec (loc, kind, npf, lp2ts) =
  p2at_make_node (loc, P2Trec (kind, npf, lp2ts))
//
(* ****** ****** *)

implement
p2at_ignored (loc) = p2at_make_node (loc, P2Tignored())

(* ****** ****** *)

(* end of [postiats_p2at.dats] *)
