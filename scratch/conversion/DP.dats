#define NPHIL 5

staload "spin.sats"
staload "Promela.sats"


(* ****** ****** *)

sortdef phil_id = {n: nat | n < NPHIL}
sortdef fork_id = {n: nat | n < NPHIL}

typedef phil (n: int) = int n
typedef phil = [n:phil_id] phil (n)


// stadef phil_left_num (n: int) = n
// stadef phil_right_num (n: int) = (n + 1) % NPHIL
stacst phil_left_num: int -> int
stacst phil_right_num: int -> int

extern
praxi phil_left_num {n:int} (): [phil_left_num (n) == n] unit_p

extern
praxi phil_right_num {n:int} (): 
  [phil_right_num (n) == (n+1)%NPHIL] unit_p

// extern
// praxi phil_left_isful 
// {a,b,c: int | phil_left_b (a, b) && phil_left_b (a, c)}():
// [b == c] void
// 
// extern
// praxi phil_right_isful 
// {a,b,c: int | phil_right_b (a, b) && phil_right_b (a, c)}():
// [b == c] void
(* ****** ****** *)

fun phil_left {n:phil_id} (n: phil n): 
  [f: fork_id | phil_left_num (n) == f] int f =
  let
    prval p = phil_left_num{n} ()
  in
    n
  end

fun phil_right {n:phil_id} (n: phil n): 
  [f: fork_id | phil_right_num (n) == f] int (f) =
  let
    prval p = phil_right_num{n} ()
  in
    nmod (n + 1, NPHIL)
  end

(* ****** ****** *)
//
absview fork_v (n: int)
viewdef fork (n: int) = fork_v (n)
//
(* ****** ****** *)

extern fun fork_acquire {n: fork_id} (n: int n): (fork n | void)
extern fun fork_release {n: fork_id} (f: fork (n) | n: int n): void

fun phil_acquire_lfork {n: phil_id} (n: phil n): 
  [f: fork_id | phil_left_num (n) == f](fork f | void) = 
  fork_acquire (phil_left (n))

fun phil_release_lfork {n: phil_id}{f: fork_id | phil_left_num (n) == f} 
  (f: fork f | n: phil n): void = 
  fork_release (f | phil_left (n))

(* ****** ****** *)

fun phil_acquire_rfork {n:phil_id} (n: phil n): 
  [f: fork_id | phil_right_num (n) == f] (fork f | void) =
  fork_acquire (phil_right (n))

fun phil_release_rfork {n:phil_id}{f:fork_id | phil_right_num (n) == f}
  (f: fork f | n: phil n): void =
  fork_release (f | phil_right (n))

(* ****** ****** *)

extern fun phil_dine (n: phil): void

extern fun phil_think (n: phil): void

extern fun phil_loop2 (n: phil): void

(* ****** ****** *)

implement phil_dine (n) = {
  val (fvl | ()) = phil_acquire_lfork (n)
  val (fvr | ()) = phil_acquire_rfork (n)
  val () = phil_think (n)
  val v = phil_release_rfork (fvr | n)
  val () = phil_release_lfork (fvl | n)
}

// proctype
fun phil (n: phil): void = phil_loop2 (n)

implement phil_loop2 (n) = let
  val () = phil_think (n)
  val () = phil_dine (n)
in
  phil_loop2 (n)
end

local

stacst fork_arr: gname

val fork_arr = array_create {..}{fork_arr}(NPHIL, 0)

extern prfun fork_v_get {n: fork_id} (): fork (n)
extern prfun fork_v_release {n: fork_id} (n: fork n): void

in

implement fork_acquire (n) = Promela$atomic (
  lam () => let
    val () = Promela$wait_until (lam() => array_get{int} (fork_arr, n) <> 0)
    val () = array_set (fork_arr, n, 1)
    prval fork = fork_v_get ()
  in
    (fork | ())
  end
)

implement fork_release (fv | n) = {
  val () = array_set (fork_arr, n, 0)
  prval () = fork_v_release (fv)
}

end  // end of [local]




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




