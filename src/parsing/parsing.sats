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
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./../postiats/utfpl.sats"
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

fun parse_stamp (jsv: jsonval): stamp
fun parse_symbol (jsv: jsonval): symbol
fun parse_location (jsv: jsonval): loc_t

(* ****** ****** *)

fun parse_label (jsv: jsonval): label

(* ****** ****** *)

fun parse_funkind: jsonval -> funkind
fun parse_valkind: jsonval -> valkind

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

(* ****** ****** *)

typedef d2cstmap = $HT.hashtbl (stamp, d2cst)
fun parse_d2cst (d2cstmap: d2cstmap, jsv: jsonval): d2cst
fun parse_d2cstmap (jsv: jsonval): d2cstmap

fun parse_d2cst_extdef (jsv: jsonval): Option string

(* ****** ****** *)

typedef d2varmap = $HT.hashtbl (stamp, d2var)
fun parse_d2var (d2varmap: d2varmap, jsv: jsonval): d2var
fun parse_d2varmap (jsv: jsonval): d2varmap

(* ****** ****** *)
typedef d2parsingenv = '{
  d2parsingenv_d2cstmap = d2cstmap
  , d2parsingenv_d2varmap = d2varmap
  }

fun parse_d2sym (jsv: jsonval): d2sym

(* ****** ****** *)

fun parse_p2at (d2varmap: d2varmap, jsv: jsonval): p2at
fun parse_p2atlst (d2varmap: d2varmap, jsv: jsonval): p2atlst

(* ****** ****** *)

fun parse_d2exp (d2parsingenv, jsv: jsonval): d2exp
fun parse_d2explst (d2parsingenv, jsv: jsonval): d2explst
fun parse_d2expopt (d2parsingenv, jsv: jsonval): d2expopt

(* ****** ****** *)

fun parse_d2ecl (d2parsingenv, jsv: jsonval): d2ecl
fun parse_d2eclist (d2parsingenv, jsv: jsonval): d2eclist

(* ****** ****** *)

fun parse_d2eclist_export (jsv0: jsonval): d2eclist

(* ****** ****** *)

(* end of [parsing.sats] *)
