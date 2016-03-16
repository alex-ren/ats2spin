(*
** Start Date: 03/09/2016
** Author: Zhiqiang ren
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"


// staload  // todo
// STRING = "libc/SATS/string.sats"

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

staload "parsing/parsing.sats"

dynload "postiats/utfpl_dynloadall.dats"
dynload "./parsing/dynloadall.dats"

fun postiats2jsonval (inp: FILEref): jsonval = let
  val dp = 1024 // depth
  val tkr = json_tokener_new_ex (dp)
  val () = assertloc (json_tokener2ptr (tkr) > 0)
  //
  val cs =
    fileref_get_file_string (inp)
  //
  val jso = let
  //
  val cs2 = $UN.strptr2string(cs)
  val len = g1u2i(string_length(cs2))
  //
  in
    json_tokener_parse_ex (tkr, cs2, len)
  end // end of [val]
  //
  val ((*void*)) = strptr_free (cs)
  val ((*void*)) = json_tokener_free (tkr)
  //
  val jsv0 = json_object2val0 (jso)
  //
  val () =
    fprint! (stdout_ref, "jsv0=", jsv0)
  val () = fprint_newline (stdout_ref)
  //
in jsv0 end

implement main0 () = let
  val () = println! "hello"

in
end


