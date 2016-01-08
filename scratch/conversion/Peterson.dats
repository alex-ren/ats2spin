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
//
extern
fun
proctype$user(): void
//
//
sortdef two = {a:nat | a < 2}
//
// macro
extern fun get_other_party{i:two}(pid(i)): pid(1-i)

// macro
extern
fun
flag_get{i:two}(pid(i)): bool
// inline
and
flag_set{i:two}(pid(i), bool): void
//
(* ****** ****** *)
//
// macro
extern
fun turn_get(): [i:two](pid(i))
// inline
extern
fun turn_set{i:two}(pid(i)): void
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

(* ****** ****** *)

(* end of [Peterson.dats] *)
