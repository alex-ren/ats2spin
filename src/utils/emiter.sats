(* ****** ******* *)
// fineprinter.sats
// Start: 2016/03/18
// Zhiqiang Ren
// aren@bu.edu
(* ****** ******* *)

staload "libats/ML/SATS/basis.sats"


(* ****** ****** *)

datatype 
emit_unit =
| EUindent of ()
| EUunindent of ()
| EUlwrapper of ()
| EUrwrapper of ()
| EUnewline of ()
| EUstring of string
| EUint of int
| EUlist of eulist
where
eu = emit_unit
and
eulist = list0 (emit_unit)

(* ****** ****** *)

typedef
emit_type
  (a:t@ype) = (a) -> eu

typedef
emit_type_list
  (a:t@ype) = (a) -> eulist

(* ****** ****** *)
//



fun emit_text : emit_type (string)
fun emit_int : emit_type (int)
fun emit_newline (): eu
fun emit_indent (): eu
fun emit_unindent (): eu
fun emit_lwrapper (): eu
fun emit_rwrapper (): eu

//
(*
* Desc: Add left, right wrapper and seperator into
* the list.
*)
fun emit_unit_list_process (
  eus: eulist
  , sep: string
  , lwrapper: string
  , rwrapper: string): eulist

fun emit_list {a:type} (
  xs: list0 a
  , sep: eu
  , lwrapper: eu
  , rwrapper: eu
  , fopr: a -<cloref1> eu): eulist
  

fun fprint_emit_unit (out: FILEref, eu: eu): void
fun fprint_emit_unit_list (out: FILEref, eus: eulist): void

// fun emit_d0eclist: emit_type_list (d0eclist)
// fun emit_d0ecl: emit_type (d0ecl)
// fun emit_i0de: emit_type (i0de)
// fun emit_f0decl: emit_type (f0decl)
// fun emit_f0head: emit_type (f0head)
// fun emit_f0body: emit_type (f0body)
// fun emit_f0marg: emit_type (f0marg)
// fun emit_s0exp: emit_type (s0exp)
// fun emit_f0arg: emit_type (f0arg)
// fun emit_tmpdeclst: emit_type_list (tmpdeclst)
// fun emit_instrlst: emit_type_list (instrlst)
// fun emit_tmpdec: emit_type (tmpdec)
// fun emit_instr: emit_type (instr)
// fun emit_label: emit_type (label)
// fun emit_d0exp: emit_type (d0exp)
// fun emit_d0explst: emit_type_list (d0explst)
// fun emit_s0explst: emit_type_list (s0explst)
// 
// 
// fun token2string (tok: token): string
// fun fkind2string (fk: fkind): string














fun emit_ENDL : FILEref -> void
fun emit_SPACE : FILEref -> void
//
fun emit_COLON : FILEref -> void
fun emit_COMMA : FILEref -> void
fun emit_SEMICOLON : FILEref -> void

// fun{} datcon_d0ecl_node : (d0ecl_node) -> string
// fun{} datcon_token_node : (token_node) -> string
// fun{} datcon_fkind_node : (fkind_node) -> string
// fun{} datcon_instr_node : (instr_node) -> string
// fun{} datcon_d0exp_node : (d0exp_node) -> string
// fun{} datcon_s0exp_node : (s0exp_node) -> string


