
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

%{
bool turn, flag[2];
byte cnt;


#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n
%}

extern prfun lemma_pid_scope (): 
[0 <= curpid && curpid < 2] void


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
         + (i = turn_get()))

    // mcval lock = Promela$vlock_get ()
    //
    // This is a critial section
    //
    // mcval () = Promela$vlock_release (lock)

    val () = flag_set(i, false)
  in 
    inline$loop (i, j) 
  end
in
  inline$loop (i, j)
end  // end of [proctype$proc]

(* ****** ****** *)

(* end of [Peterson.dats] *)



