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

(* end of [Promela.sats] *)


