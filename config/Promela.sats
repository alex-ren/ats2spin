(* ****** ****** *)
//
// For embedding
// Promela into ATS
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: December, 2015

// Author: Zhiqiang Ren
// Email: aren@bu.edu
//
(* ****** ****** *)
stacst curpid: int
//
abstype
pid (i:int)
//
// typedef
// pid(i:int) = pid_type(i)
//
typedef pid = [i:nat] pid(i)
//
(* ****** ****** *)
//
fun
pid2int{i:nat}(pid(i)): int(i)

fun 
pid_eq{i1,i2:nat}(pid(i1), pid(i2)): bool(i1 == i2)

overload = with pid_eq

castfn int2pid {i:nat} (i: int i): pid i
castfn pid2int {i:nat} (p: pid i): int i

//
(* ****** ****** *)
//
fun
pml$mypid(): [curpid >= 0] pid curpid = "ext#get_pid"
//
fun
pml$assert{b:bool}(bool(b)): [b==true] void = "ext#assert"

fun
pml$assert0 (bool): void = "ext#assert"
//
(* ****** ****** *)
//
#define pml$random 0

(* ****** ****** *)

sortdef gname = int

fun
pml$wait_until {b: bool} (() -> bool b): [b == true] void

fun
pml$wait_until0 (() -> bool): void

fun
pml$run (void): pid

(* ****** ****** *)

prfun
Promela$set_tag (tag: string): void

fun
Promela$atomic {a:viewt@ype} (() -> a): a

(* ****** ****** *)

(* ****** ****** *)
// Channel related primitives

abstype pml$chan

(* **************** **************** *)

// create local channels
// ATS/PML compiler shall generate the body of this function in PML.
fun pml$chan_create$
  {a:vt@ype}(*type of payload*) {b:vt@ype} (*type of channel*) (
  int (*buffer size, must be constant when invoked*)
  ): b

// Patterns for operations are similar,
// but types for operations can be very sophisticated.
fun pml$chan_recv$
  {pt:vt@ype} {b:vt@ype} (ch: !b): pt

fun pml$chan_send$
  {pt:vt@ype} {b:vt@ype} (ch: !b, ele: pt): void

fun pml$chan_isempty$ {a:vt@ype} (ch: !a): bool

fun pml$chan_isnotempty$ {a:vt@ype} (ch: !a): bool

prfun pml$chan_destroy$ {a:vt@ype} (ch: a): void

(* ****** ****** *)

abstype pml$array (a:t@ype)

fun pml$array_create$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  int (*array size, must be constant when invoked*)
  , ele: a // initial value
  ): b

fun pml$array_get$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  arr: !b
  , n: int
  ): a

fun pml$array_set$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  arr: !b
  , ele: a
  , n: int
  ): void

(* ****** ****** *)

absview atomic_view
viewdef atom_v = atomic_view

// 
// prfun Promela$begin_atomic (): (atomic_view | void)
// prfun Promela$end_atomic(atomic_view): void
  
// abstype garray (a:t@ype, g: gname, n: int)
// 
// fun array_create {a:t@ype}{g:gname}{n:nat} (n: int n, init: a):
//   garray (a, g, n)
// 
// fun array_get {a:t@ype}{g:gname}{i,n:nat | i < n} (
//   arr: garray (a, g, n), i: int i): a
// 
// fun array_set {a:t@ype}{g:gname}{i,n:nat | i < n} (
//   arr: garray (a, g, n), i: int i, v: a): void

(* ****** ****** *)

abst@ype gid_t = int

fun {a:t0ype} promela_gvar_dec (): gid_t
fun {a:t0ype} promela_gvar_create (x: a): gid_t
fun {a:t0ype} promela_gvar_get (gid: gid_t): a
fun {a:t0ype} promela_gvar_set (gid: gid_t, x: a): void



(* end of [Promela.sats] *)



