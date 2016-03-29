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
//
abstype
pid_type(i:int)
//
typedef
pid(i:int) = pid_type(i)
//
typedef pid = [i:nat] pid(i)
//
(* ****** ****** *)
//
fun
pid2int{i:nat}(pid(i)): int(i)

fun
int2pid{i:nat}(int(i)): pid(i)

fun 
pid_eq{i1,i2:nat}(pid(i1), pid(i2)): bool(i1 == i2)

overload = with pid_eq
//
(* ****** ****** *)
//
fun
Promela$mypid(): pid
//
fun
Promela$assert{b:bool}(bool(b)): [b==true] void
//
(* ****** ****** *)

sortdef gname = int

fun
Promela$wait_until(() -> bool): void
fun
Promela$wait_unless(() -> bool): void

fun
Promela$atomic {a:viewt@ype} (() -> a): a

fun
Promela$run (() -> void): void
abstype process_end
fun Promela$run2 (process_end): void

fun Promela$process_end (): process_end

prfun
Promela$set_tag (tag: string): void

(* ****** ****** *)

// absview atomic_view
// viewdef atom_v = atomic_view
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

fun {a:t0ype} promela_gvar_int_array_dec (sz: int): gid_t
fun {a:t0ype} promela_gvar_int_array_get (gid: gid_t, n: int): int
fun {a:t0ype} promela_gvar_int_array_set (gid: gid_t, n: int, x: int): void

fun {a:t0ype} promela_gvar_chan_dec (cap: int): gid_t
fun {a:t0ype} promela_gvar_chan_create (cap: int): gid_t




(* end of [Promela.sats] *)



