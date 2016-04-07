(*
//
// two processes
//
active[2]
proctype user()
{
  assert(_pid == 0 || _pid == 1);
  again:
  flag[_pid] = 1; turn = 1 - _pid;
  (flag[1 - _pid] == 0 || turn == _pid);
//
  ncrit++;
  assert(ncrit == 1); // critical section
  ncrit--;
//
  flag[_pid] = 0; goto again
}
*)

(* ****** ****** *)

staload "./Promela.sats"

(* ****** ****** *)

(* ****** ****** *)
//
sortdef two = {a:nat | a < 2}

// todo: How to implement this function?
// We can use assertion in model checking.
// Can we do pure proof?
extern prfun lemma_pid_max (): 
[0 <= curpid () && curpid () < 2] void
//
// proctype
extern
fun
proctype$user (): void
//
//
// macro
extern
fun
flag_get{i:two}(pid(i)): bool

// inline
// Only set itself
extern
fun
flag_set {curpid () < 2 && curpid () >= 0}(pid(curpid ()), bool): void
//
(* ****** ****** *)
//
// macro
extern
fun turn_get(): [i:two] (pid(i))

// inline
extern
fun turn_set {curpid () < 2 && curpid () >= 0} (pid(curpid ())): void
//

extern fun 
get_other_party {curpid () < 2 && curpid () >= 0}
  (pid (curpid ())): pid(1 - curpid ())

(* ****** ****** *)

implement
proctype$user() = let
  //
  val pid = Promela$mypid ()
  // val ((*void*)) =
  //   Promela$assert((pid=0)+(pid=1))
  prval () = lemma_pid_max ()
  //
  // inline
  fun
  loop
  (
    pid: pid (curpid ())
  ) : void = let
    val () = flag_set(pid, true)
    val () = turn_set(pid)
    val () = Promela$wait_until(
      lam() => (flag_get(get_other_party(pid))=false)
         || (pid = turn_get()))
    //
    // This is a critial section
    //
    val () = flag_set(pid, false)
  in
    loop (pid) 
  end

in
  loop (pid)
end  // end of [proctype$user]

(* ****** ****** *)

(* end of [Peterson.dats] *)



