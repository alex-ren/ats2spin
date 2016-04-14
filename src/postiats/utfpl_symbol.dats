(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"
(* ****** ****** *)

staload "./../utils/emiter.sats"

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

datatype symbol = SYM of (string, int)

(* ****** ****** *)

assume symbol_type = symbol

(* ****** ****** *)

local

staload LM = "libats/ML/SATS/hashtblref.sats"

staload HF = "libats/SATS/hashfun.sats"

staload _ = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"


staload UN = "prelude/SATS/unsafe.sats"

typedef symbol_map_t = $LM.hashtbl (string, symbol)

val count = ref<int> (0)
val mymap = ref<symbol_map_t> ($LM.hashtbl_make_nil (i2sz(2048)))

in (* in of [local] *)

implement the_symbol_mgr_initialize () = let
  val () = !count := 0
  val () = !mymap := $LM.hashtbl_make_nil (i2sz(2048))
in
end

implement
emit_symbol (symbol) = let
  val+ SYM (str, v) = symbol
in
  EUstring (str)
end

implement
symbol_make (name) = let
//
val opt = $LM.hashtbl_search (!mymap, name)
//
in
//
case+ opt of
| ~Some_vt (sym) => sym
| ~None_vt ((*void*)) => let
    val n = !count
    val () = !count := n + 1
    val sym = SYM (name, n)
//
    val () = $LM.hashtbl_insert_any (!mymap, name, sym)
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

implement
eq_symbol_symbol (sym1, sym2) =
  compare_symbol_symbol (sym1, sym2) = 0

local 
staload HF = "libats/SATS/hashfun.sats"
staload "libats/ML/SATS/hashtblref.sats"

staload _ = "libats/DATS/hashfun.dats"

in
implement
hash_symbol (s) = let
  val+SYM (_, n) = s
in
$UNSAFE.cast{ulint}
  ($HF.inthash_jenkins($UNSAFE.cast{uint32}(n)))
end
end  // end of [local]

(* ****** ****** *)

(* end of [utfpl_symbol.dats] *)


