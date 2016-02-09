
(* ****** ****** *)

staload "./Promela.sats"

sortdef two = {a:nat | a < 2}

(* ****** ****** *)
//
// todo: In reality curpid is not a constant function.
// How to incorporate it into the type system?
stacst curpid: () -> int

stacst g_islocked: gname
// todo: In reality g_get_islocked depends on timing.
// How to incorporate it into the type system?
stacst g_get_islocked: gname -> bool


extern prfun lemma_pid_max (): [curpid () < 2] void
//
extern fun get_other_party (pid (curpid ())): pid(1- curpid ())

extern
fun
flag_get{i:two}(pid(i)): bool
// inline
and
flag_set{i:two}(pid(i), bool): void
//
(* ****** ****** *)
absview vlock_v (int)

extern
fun turn_tryget(): [r: two] (option_v (vlock_v r, curpid () == r) | pid r)

extern
fun turn_yieldto_v{i:two | i != curpid ()}(vlock_v (curpid ()) | pid(i)): void

extern
fun turn_set_self {g_get_islocked (g_islocked) == false} (pid (curpid ())): void

////
//
(* ****** ****** *)

implement
proctype$user() = let
//
val pid =
  Promela$mypid()
//
val i = pid2int(pid)
//
val ((*void*)) =
  Promela$assert((i=0)+(i=1))
//
// inline
fun
loop
(
// argless
) : void = loop() where
{
  val () = flag_set(pid, true)
  val () = turn_set(pid)
  val () = Promela$wait_until(
    lam() => (flag_get(get_other_party(pid))=false)
       || (pid_eq(pid, turn_get())))
//
// This is a critial section
//
  val () = flag_set(pid, false)
}
//
in
  loop()
end // end of [proctype$user]


extern t
