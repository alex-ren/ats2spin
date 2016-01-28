
staload "../Promela.sats"

#define N 3

datatype mtype =
| Wakeme of ()
| Running of ()

extern fun cmp_mtype_mtype (x: mtype, y: mtype): bool

overload = with cmp_mtype_mtype

stacst r_lock: gname
stacst r_wanted: gname
stacst lk: gname
stacst sq: gname


absview lock_v (n: gname)

stacst dd: string

abstype gname (n: string, m: gname)
assume gname = string
////

// atomic
extern fun pstate_get {i:nat | i < N} (v: !lock_v sq | i: int i): mtype
// atomic
extern fun pstate_set {i:nat | i < N} (v: !lock_v sq | i: int i, x: mtype): void
// atomic
extern fun pstate_init (x: mtype): void

extern fun freelock_sq (lock_v (sq)): void
extern fun spinlock_sq (): (lock_v (sq) | void)

extern fun freelock_lk (lock_v (lk)): void
extern fun waitlock_lk (): void
extern fun spinlock_lk (): (lock_v (lk) | void)

extern fun freelock {lk:gname} (lock_v (lk)): void
extern fun waitlock (): void
extern fun spinlock {lk:gname} (): (lock_v (lk) | void)

fun wakeup () = let
  val (v | ()) = spinlock_sq  ()

  fun loop {i:nat | i <= N} (v: !lock_v sq | i: int i): void =
    if i < N then 
      if pstate_get (v | i) = Wakeme then let
        val () = pstate_set (v | i, Running)
      in 
        loop (v | i + 1)
      end else loop (v | i + 1)
  
  val () = loop (v | 0)

  val () = freelock_sq (v)
in end


