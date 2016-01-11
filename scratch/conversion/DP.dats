#define NPHIL 5

staload "spin.sats"
staload "Promela.sats"


typedef phil (n: int) = int n

(* ****** ****** *)

fun phil_left {n:int} (n: phil n): int (n) = n

extern fun phil_right {n:nat} (n: phil n): [m:nat | m < NPHIL] int m 
// = (n + 1) mod NPHIL

(* ****** ****** *)
//
absvt@ype
fork_vtype = int
//
vtypedef fork = fork_vtype
//
(* ****** ****** *)

extern fun randsleep (n: intGte(1)): void

(* ****** ****** *)
extern fun fork_acquire {n: nat | n < NPHIL} (n: int n): fork
extern fun fork_release {n: nat | n < NPHIL} (n: int n, f: fork): void


fun phil_acquire_lfork (n: phil): fork = 
  fork_acquire (phil_left (n))

fun phil_release_lfork (n: phil, f: fork): void =
  fork_release (phil_left (n), f)

(* ****** ****** *)

fun phil_acquire_rfork (n: phil): fork =
  fork_acquire (phil_right (n))

fun phil_release_rfork (n: phil, f: fork): void =
  fork_release (phil_right (n), f)

(* ****** ****** *)

extern fun phil_dine (n: phil): void

extern fun phil_think (n: phil): void

extern fun phil_loop2 (n: phil): void

(* ****** ****** *)

// proctype
fun phil (n: phil): void = phil_loop2 (n)

implement phil_loop2 (n) = let
  val () = phil_think (n)
  val () = phil_dine (n)
in
  phil_loop2 (n)
end

stacst fork_arr: gname
val fork_arr = array_create {..}{fork_arr}(5, 0)


local
  
implement fork_acquire (n) = let
  val () = Promela$wait_until (lam() => array_get (n) != 0)
in
end
in
end




////
implement phil_dine (n) = 

// Configuration
// abstype configure
// 
// fun initiate (ntot: int): configure = let
//   val conf = configure_nil ()
//   fun loop (i: int, conf: configure): configure =
//     if i < ntot then let
//       val proc = active_proc (phil, i)
//       val conf' = concur_run (proc, conf)
//     in
//       loop (i + 1, conf')
//     end else conf
// 
// in
//   loop (0, conf)
// end




