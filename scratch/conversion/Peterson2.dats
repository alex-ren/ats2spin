
(* ****** ****** *)

staload "./Promela.sats"

sortdef two = {a:nat | a < 2}

(* ****** ****** *)
//
// todo: In reality curpid is not a constant function.
// How to incorporate it into the type system?
// One thing good about curpid is that it is not dependent
// on time.
stacst curpid: () -> int

// todo: How to implement this function?
// We can use assertion in model checking.
// Can we do pure proof?
extern prfun lemma_pid_max (): [0 <= curpid () && curpid () < 2] void
//
extern fun get_other_party (pid (curpid ())): pid(1 - curpid ())

(* ****** ****** *)

extern
fun
flag_get{i:two}(pid(i)): bool

and
flag_set (pid(curpid ()), bool): void
//
(* ****** ****** *)
// 
absview vlock_v
// In the world of model checking, there's a global variable
// g_locked which indicates whether the view has been taken
// by a thread or is still in the global box.

stacst g_locked: gname
// todo: In reality get_g_locked depends on timing.
// How to incorporate it into the type system?
stacst get_g_locked: gname -> bool


extern
fun turn_tryget(): [r: two] (option_v (vlock_v, curpid () == r) | pid r)

extern
fun turn_yieldto_v {i:two | i != curpid ()}(vlock_v | pid(i)): void

extern
fun turn_yieldto {i:two | i != curpid ()}(pid(i)): void

extern
fun turn_set_self {get_g_locked (g_locked) == false} (pid (curpid ())): void

//
(* ****** ****** *)

extern fun get_cur_pid (): pid (curpid ())

// proctype
fun user (): void = let
  val curpid = get_cur_pid ()
  val other_pid = get_other_party (curpid)
  prval () = lemma_pid_max ()  // may be proof, may be model checking
  val () = flag_set (curpid, true)
  val () = turn_yieldto (other_pid)
  
  val () = if (~flag_get (other_pid)) then let

      // todo: How to prove this lemma?
      extern prfun lemma_not_locked (): [get_g_locked (g_locked) == false] void
      prval () = lemma_not_locked ()
      val () = turn_set_self (curpid)
  in end else ()

  fun loop (): (vlock_v | void) = let
    val (opv | pid) = turn_tryget ()
  in
    if (pid = curpid) then let
      prval Some_v (v) = opv
    in (v | ()) end else let prval None_v () = opv in loop () end
  end

  val (v | ()) = loop ()
  // critical section
  val () = flag_set (curpid, false)  // have to release the flag first
  val () = turn_yieldto_v (v | other_pid)
in user () end



