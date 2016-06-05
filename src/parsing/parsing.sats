(*
** Parsing: ATS/JSON -> UTFPL
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Start time: December, 2013
*)

(* ****** ****** *)

(*
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"

staload "libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

staload "./../postiats/postiats.sats"
staload HT = "libats/ML/SATS/hashtblref.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)
//
fun jsonval_get_field
  (jsv: jsonval, name: string): Option_vt (jsonval)
//
(* ****** ****** *)

// Call this function to initialize (or reset)
// the inner state of the parser.
fun parser_initialize (): void

fun parse_int (jsv: jsonval): int
fun parse_string (jsv: jsonval): string

(* ****** ****** *)

fun{
a:t@ype
} parse_list
  (jsv: jsonval, f: jsonval -<cloref1> a): List0 (a)
// end of [parse_list]

(* ****** ****** *)

fun{
a:t@ype
} parse_option
  (jsv: jsonval, f: jsonval -<cloref1> a): Option (a)
// end of [parse_option]

fun{
a:t@ype
} parse_list0
  (jsv: jsonval, f: jsonval -<cloref1> a): list0 (a)
// end of [parse_list0]

(* ****** ****** *)

fun{
a:t@ype
} parse_option0
  (jsv: jsonval, f: jsonval -<cloref1> a): option0 (a)
// end of [parse_option0]

(* ************ end of paring utility ************ *)

fun parse_stamp (jsv: jsonval): stamp
fun parse_symbol (jsv: jsonval): symbol
fun parse_location (jsv: jsonval): loc_t

(* ****** ****** *)

fun parse_label (jsv: jsonval): label

(* ****** ****** *)

typedef s2cstmap = $HT.hashtbl (stamp, s2cst)
fun parse_s2cst (s2cstmap: s2cstmap, jsv: jsonval): s2cst

fun parse_s2cstmap (jsv: jsonval): s2cstmap

(* ****** ****** *)

fun parse_s2rt (jsv: jsonval): s2rt

(* ****** ****** *)

typedef s2varmap = $HT.hashtbl (stamp, s2var)
fun parse_s2var (s2varmap: s2varmap, jsv: jsonval): s2var

fun parse_s2varmap (jsv: jsonval): s2varmap

(* ****** ****** *)

typedef s2parsingenv = '{
  s2parsingenv_s2cstmap = s2cstmap
  , s2parsingenv_s2varmap = s2varmap
  }

fun s2parsingenv_make (s2cstmap, s2varmap): s2parsingenv

(* ****** ****** *)

fun parse_s2exp_node (s2parsingenv, jsonval): s2exp 

fun parse_s2exp (s2parsingenv, jsonval): s2exp 

(* ****** ****** *)

fun parse_funkind: jsonval -> funkind
fun parse_valkind: jsonval -> valkind
fun parse_casekind: jsonval -> casekind

(* ****** ****** *)


typedef d2cstmap = $HT.hashtbl (stamp, d2cst)

fun parse_d2cst (s2env: s2parsingenv, d2cstmap: d2cstmap, jsv: jsonval): d2cst
fun parse_d2cst_extdef (jsv: jsonval): Option string

fun parse_d2cstmap (s2env: s2parsingenv, jsv: jsonval): d2cstmap

(* ****** ****** *)

typedef d2conmap = $HT.hashtbl (stamp, d2con)

fun parse_d2con (s2env: s2parsingenv, d2conmap: d2conmap, jsv: jsonval): d2con

fun parse_d2conmap (s2env: s2parsingenv, jsv: jsonval): d2conmap

(* ****** ****** *)

typedef d2varmap = $HT.hashtbl (stamp, d2var)
fun parse_d2var (d2varmap: d2varmap, jsv: jsonval): d2var
fun parse_d2varmap (jsv: jsonval): d2varmap

(* ****** ****** *)

typedef parsingenv = '{
  parsingenv_d2cstmap = d2cstmap
  , parsingenv_d2conmap = d2conmap
  , parsingenv_d2varmap = d2varmap
}
fun parsingenv_make (d2cstmap, d2conmap, d2varmap): parsingenv

fun parse_d2sym (jsv: jsonval): d2sym

(* ****** ****** *)

fun parse_p2at (s2parsingenv, d2env: parsingenv, jsv: jsonval): p2at
fun parse_p2atlst (s2parsingenv, d2env: parsingenv, jsv: jsonval): p2atlst

(* ****** ****** *)

fun parse_d2exp (s2parsingenv, parsingenv, jsv: jsonval): d2exp
fun parse_d2explst (s2parsingenv, parsingenv, jsv: jsonval): d2explst
fun parse_d2expopt (s2parsingenv, parsingenv, jsv: jsonval): d2expopt

(* ****** ****** *)

fun parse_d2ecl (s2parsingenv, parsingenv, jsv: jsonval): d2ecl
fun parse_d2eclist (s2parsingenv, parsingenv, jsv: jsonval): d2eclist

(* ****** ****** *)

fun parse_d2eclist_export (jsv0: jsonval): d2eclist

(* ****** ****** *)

(* end of [parsing.sats] *)

