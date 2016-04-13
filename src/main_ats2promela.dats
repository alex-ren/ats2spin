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


staload
  STRING = "libc/SATS/string.sats"

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

staload "./parsing/parsing.sats"
staload UTFPL = "./postiats/utfpl.sats"
staload "./instr0/instr0.sats"

dynload "./postiats/utfpl_dynloadall.dats"
dynload "./parsing/dynloadall.dats"
dynload "./instr0/dynloadall.dats"
dynload "./promela/dynloadall.dats"


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
  (*
  val () =
    fprint! (stdout_ref, "jsv0=", jsv0)
  val () = fprint_newline (stdout_ref)
  *)
  //
in jsv0 end

implement main0 (argc, argv) = let
  //
  val () =
  println! ("Hello from UTFPL0!")
  //
  // val () = the_d2symmap_init ()
  //
  var fopen: int = 0
  //
  var inpref: FILEref = stdin_ref
  //
  val () =
  if argc >= 2 then let
  //
  val opt =
    fileref_open_opt (argv[1], file_mode_r)
  //
  in
    case+ opt of
    | ~None_vt () => ()
    | ~Some_vt (inp) => (fopen := 1; inpref := inp)
  end // end of [if]
  //
  val jsv = postiats2jsonval (inpref)

  // symbol_manager
  val () = $UTFPL.the_symbol_mgr_initialize ()

  val d2ecs = parse_d2eclist_export (jsv)

  val sa = stamp_allocator_create ()
  val i0prog = i0transform_d2eclst_global (sa, d2ecs)
  val () = fprint (stdout_ref, i0prog)

  val i0prog = i0optimize_tailcall (sa, i0prog)
  val () = fprint (stdout_ref, i0prog)

  //
  val () = if fopen > 0 then fileref_close (inpref)
  //
in
  // nothing
end (* end of [main0] *)


