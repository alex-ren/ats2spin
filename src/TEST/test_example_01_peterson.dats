
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

%{
bool turn, flag[2];

#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n

int g_lock = 0;

#define vlock_acquire() \
d_step { \
assert(g_lock == 0); \
g_lock = 1; \
}

#define vlock_release() \
g_lock = 0


%}

// todo
// extern prfun lemma_pid_scope (): 
// [0 <= curpid && curpid < 2] void


extern
fun
flag_get{i:nat | i < 2}(ind: pid(i)): bool = "ext#flag_get"

extern
fun
flag_set {curpid < 2 && curpid >= 0}(
  ind: pid(curpid), v: bool): void = "ext#flag_set"

extern
fun turn_get(): [i:nat | i < 2] (pid(i)) = "ext#turn_get"

extern
fun turn_set {curpid < 2 && curpid >= 0} (
  t: pid(curpid)): void = "ext#turn_set"

// todo
// extern
// fun vlock_acquire (): (atom_v | void) = "ext#vlock_acquire"
// 
// extern
// fun vlock_release (v: atom_v): void = "ext#vlock_release"

extern
fun vlock_acquire (): void = "ext#vlock_acquire"

extern
fun vlock_release (): void = "ext#vlock_release"

(* ****** ****** *)

fun
proctype$proc() = let
  val i = pml$mypid ()

  val ((*void*)) =
    pml$assert((i = int2pid 0) + (i = int2pid 1))
  // prval () = lemma_pid_scope ()
  val j = (int2pid (1 - pid2int i)): pid (1 - curpid)
  //
  fun inline$loop (
    i: pid (curpid), j: pid (1 - curpid)
  ) : void = let
    val () = flag_set(i, true)
    val () = turn_set(i)
    val () = pml$wait_until(
      lam() => (flag_get(j)=false)
         + (j = turn_get()))

    val () = $extfcall (void, "printf", "pid: %d \\n", i)

    // todo: val (pf_lock | ()) = vlock_acquire ()
    val () = vlock_acquire ()
    //
    // This is a critial section
    //
    // todo: val () = vlock_release (pf_lock)
    val () = vlock_release ()

    val () = flag_set(i, false)
  in 
    inline$loop (i, j) 
  end
in
  inline$loop (i, j)
end  // end of [proctype$proc]

(* ****** ****** *)

fun pml$init (): void = let
  val pid1 = pml$run (lam () => proctype$proc ())
  val pid2 = pml$run (lam () => proctype$proc ())
in end

(* end of [Peterson.dats] *)



