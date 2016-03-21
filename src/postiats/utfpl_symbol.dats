(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../utils/emiter.sats"
staload "./../utils/utils.sats"
staload "./../utils/mymap.sats"

staload _(*anon*) = "./../utils/mymap.dats"
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

datatype symbol = SYM of (string, int)

(* ****** ****** *)

assume symbol_type = symbol

(* ****** ****** *)

local

val count = ref<int> (0)
val mymap = ref<mylinmap (string, symbol)> (mylinmap_create ())

in (* in of [local] *)

implement the_symbol_mgr_initialize () = let
  val () = !count := 0
  val () = !mymap := mylinmap_create ()
in
end

implement
symbol_make (name) = let
//
val opt = mylinmap_find (!mymap, name)
//
in
//
case+ opt of
| Some (sym) => sym
| None ((*void*)) => let
    val n = !count
    val () = !count := n + 1
    val sym = SYM (name, n)
//
    val _ = mylinmap_insert (!mymap, name, sym)
//
  in
    sym
  end // end of [None_vt]
//
end // end of [symbol_make]

end // end of [local]

(* ****** ****** *)
//
implement
symbol_get_name (sym) =
  let val+SYM (name, _) = sym in name end
//
(* ****** ****** *)

implement
fprint_symbol
  (out, sym) = let
//
val+SYM (name, _) = sym
//
in
  fprint_string (out, name)
end // end of [fprint_symbol]

implement
emit_symbol (sym) = let
  val+ SYM (_, n) = sym
  val id = tostring_int (n)
in
  emit_text (symbol_get_name (sym) + id)
end

(* ****** ****** *)

implement
compare_symbol_symbol
  (sym1, sym2) = let
//
val+SYM (_, n1) = sym1
val+SYM (_, n2) = sym2
//
in
  compare (n1, n2)
end // end of [compare_symbol_symbol]

(* ****** ****** *)

(* end of [utfpl_symbol.dats] *)


