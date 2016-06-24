(*
** Author: Zhiqiang ren
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"


staload
  STRING = "libc/SATS/string.sats"

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

staload "./../parsing/parsing.sats"
staload "./../postiats/postiats.sats"
staload "./../simpletypes/simpletypes.sats"
staload "./instr0.sats"

dynload "./../parsing/dynloadall.dats"
dynload "./../postiats/dynloadall.dats"
dynload "./../simpletypes/dynloadall.dats"
dynload "./dynloadall.dats"


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
  var is_debug: bool = false
  val () = if argc >= 3 then let
    val option1 = argv[2]
  in
    if option1 = "--debug" then let
      val () = is_debug := true
      val () = !is_debug_typechecking := true
    in end
  end

  val () = if is_debug then {
  val () =
  println! ("\n\n ========= Hello from ATS2PML! =============")
  }


  // symbol_manager
  val () = the_symbol_mgr_initialize ()
  //

  (* *********** ************* *)

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

  (* ************** ************** *)

  val '(d2ecs_model, max, s2env, d2env) = parse_d2eclist_export (jsv)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== level postiats ==============================\n\n")
  val () = fprint_d2eclist (stdout_ref, d2ecs_model)
  }

  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== type checking ================\n\n")
  }
  val '(d2eclist, tmap) = s3type_export (max, d2ecs_model)

  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== collecting datatype information ================\n\n")
  }
  val s3datatypelst = s3type_collect_datatype (s2env, d2env, tmap)
  // implement fprint_val<s3datatype> = fprint_s3datatype
  // val () = fprintln! (stderr_ref, "s3datatypelst is \n", s3datatypelst)


  (* ************** ************** *)

  // val () = if is_debug then {
  // val () = fprint (stdout_ref, 
  //   "\n\n## ======== datatype information ================\n\n")
  // // val () = fprint (stdout_ref, tmap)
  // }
  
  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== type information ================\n\n")
  val () = fprint (stdout_ref, tmap)
  }
  
  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== process datatype information ================\n\n")
  }
  val datatype0map = datatype0map_translate (s3datatypelst)
  val i0env = i0transform_env_create (datatype0map)

  val () = if is_debug then {
  val () = fprint_datatype0map (stdout_ref, datatype0map)
  }

  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== transform postiats to instr0 ================\n\n")
  }

  val sa = stamp_allocator_create ()
  val i0prog = i0transform_d2eclst_global (sa, i0env, d2ecs_model, tmap)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== level instr0 ==============================\n\n")
  val () = fprint (stdout_ref, i0prog)
  }

  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== optimizing tailcall on instr0 ================\n\n")
  }

  val i0prog = i0optimize_tailcall (sa, i0prog)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== level instr0 after tail call optimization =====================\n\n")
  val () = fprint (stdout_ref, i0prog)
  }

  (* ************** ************** *)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== moving declarations on instr0 ================\n\n")
  }

  val i0prog = i0optimize_collect_decs (i0prog)

  val () = if is_debug then {
  val () = fprint (stdout_ref, 
    "\n\n## ======== level instr0 after declarations movement =====================\n\n")
  val () = fprint (stdout_ref, i0prog)
  }
  

  (* ************** ************** *)

  val () = if fopen > 0 then fileref_close (inpref)
  val () = fprint (stdout_ref, "\n\n")
  //
  (* ************** ************** *)

in
  // nothing
end (* end of [main0] *)


