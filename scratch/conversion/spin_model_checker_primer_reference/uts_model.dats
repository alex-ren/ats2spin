
staload "../Promela.sats"

#define N 3

datatype mtype =
| Wakeme of ()
| Running of ()

extern fun cmp_mtype_mtype (x: mtype, y: mtype): bool

overload = with cmp_mtype_mtype

(* *********** ************* *)

(* *********** ************* *)

// stacst r_lock: gname
extern fun r_lock_get (): bool
extern fun r_lock_set (b: bool): void

// stacst r_wanted: gname
extern fun r_wanted_get (): bool
extern fun r_wanted_set (b: bool): void

(* *********** ************* *)

abstype lock (n: gname)

stacst lk: gname // protect resource
extern val lk: lock (lk)

absview lock_v (n: gname)

extern fun freelock {lk:gname} (lock_v (lk) | lock lk): void
extern fun waitlock {lk:gname} (lock lk): void
extern fun spinlock {lk:gname} (lock lk): (lock_v (lk) | void)

(* *********** ************* *)

stacst sq: gname // protect process states
// sq conntects the "freelock_sq" and the "pstate_get" operations.

extern fun freelock_sq (lock_v (sq)): void
extern fun spinlock_sq (): (lock_v (sq) | void)

(* *********** ************* *)

// atomic
extern fun pstate_get {i:nat | i < N} (i: int i): mtype
// atomic
extern fun pstate_set {i:nat | i < N} (v: !lock_v sq | i: int i, x: mtype): void

(* *********** ************* *)


fun wakeup () = let
  val (v | ()) = spinlock_sq  ()

  fun loop {i:nat | i <= N} (v: !lock_v sq | i: int i): void =
    if i < N then 
      if pstate_get (i) = Wakeme then let
        val () = pstate_set (v | i, Running)
      in 
        loop (v | i + 1)
      end else loop (v | i + 1)
  
  val () = loop (v | 0)

  val () = freelock_sq (v)
in end

fun sleepl {l:gname} {i:nat| i < N} (
  gv: lock_v l | i: int i, l: lock (l)): (lock_v l | void) = let
  val (v_sq | ()) = spinlock_sq ()
  val () = freelock (gv | l)

  val () = pstate_set (v_sq | i, Wakeme)
  val () = freelock_sq (v_sq)

  val () = Promela$wait_until(
    lam () => pstate_get (i) = Running)

  val (v | ()) = spinlock (l)
in (v | ()) end


// i: index used to replace the usage of _pid.
// Thus the reasoning of _pid can be incorporated
// into ATS.
fun proctype_user {i:nat | i < N} (i: int i) = let
  fun loop (): void = let
    val (v_lk | ()) = spinlock (lk)

    fun loop2 (v_lk: lock_v lk): (lock_v lk | void) = 
      // todo: If r_lock_get () == 1, then there exists a V.
      // register itself to a global entry blockees.
      if r_lock_get () then let
        val () = r_wanted_set (true)
        val (v_lk | ()) = sleepl (v_lk | i, lk)
      in loop2 (v_lk) end else (v_lk | ())

    val (v_lk | ()) = loop2 (v_lk)

    val () = r_lock_set (true)
    val () = freelock (v_lk | lk)

    prval () = Promela$set_tag ("R")

    val () = r_lock_set (false)

    // Without the following, there is a problem as follows:
    // Suppose there are two processes A and B. A goes first and
    // block B.
    // B checks "r_lock_get ()" and is about to "r_wanted_set (true)".
    // A uses "r_wanted_get ()" to get false and totally skips
    // waking B.
    // With the following statement, there is no missed wake up
    // for two processes.
    val () = waitlock (lk)
  in
    // todo: If exists V, then true, else false.
    if (r_wanted_get ()) then let
      // grab the current global entry blockees.
      // grab all the V's
      val () = r_wanted_set (false)

      // Without the following, there is a problem when there are
      // three processes. A goes first and stop before "r_wanted_get ()".
      // B goes second and B is not blocked by A at all since A already
      // left its critical section. C goes third and "r_wanted_set (true)"
      // due to B "r_lock_set (true)". A is completely asynchronous to
      // C and then can "r_wanted_set (false)" before C actually enters
      // sleep state, and thus A won't wake up C. B won't wake up C either
      // since "r_wanted_get ()" is false.
      val () = waitlock (lk)
      // Inside the wakeup, all the blockees must be
      // of state Wakeme. :( This is not a valid statement.)
      // The blockees may have been awaken by other processes.
      // wakeup consumes all the V's collected so far.
      val () = wakeup ()
    in loop () end else loop ()
  end

  val () = loop ()
in end

(* *********** ************* *)

// initialize
typedef Promela$proctype (bound: int) = {i: nat | i < bound} (int i) -> void

extern fun Promela$active_proctype_n {n:nat} (
  n: int n, proc: Promela$proctype n): void

val () = Promela$active_proctype_n (N, proctype_user)

// extern fun Promela$global_array_initialize {n:nat} (
//   g: Promela$global_array n, init: mtype): void

// val () = Promela$global_array_initialize (pstate, Running)





