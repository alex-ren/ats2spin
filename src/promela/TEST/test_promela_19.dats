

/*
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"


abstype chnil
abstype chcons(x:vt@ype, xs:type)

(* ****** ****** *)

stadef :: = chcons

(* ****** ****** *)

abstype chanref(a:vtype)

(* ****** ****** *)

absvtype chanptr(a:vtype)

(* ****** ****** *)
//
absvtype channel0
//
absvtype chanpos1(ss:vtype)
absvtype channeg1(ss:vtype)

extern
fun
channel0_create
  (cap: intGte(0)): channel0
//
extern
fun channel0_destroy(channel0): void


extern
fun
channel0_split{ss:vtype}
  (chan: !channel0 >> chanpos1(ss)): channeg1(ss)
//
(* ****** ****** *)
//
extern
prfun
channeg1_nil_close (channeg1(chnil)): void
extern
prfun
chanpos1_nil_close (!chanpos1(chnil) >> channel0): void

// extern
// fun
// chanpos1_recv
// {x:vt@ype}{xs:type}
// (
//   chan: !chanpos1(x::xs) >> chanpos1(xs)
// ) : x // end of [chanpos1_recv]
// 
// (* ****** ****** *)
// 
// extern
// fun
// channeg1_send
// {x:vt@ype}{xs:type}
// (
//   chan: !channeg1(x::xs) >> channeg1(xs), x: (x)
// ) : void // end of [channeg1_send]




absvtype ss_client = ptr

absvtype ss_grant = ptr

datavtype
ClientOpt(ss:vtype) =
  | DENY(chnil) of ()
  | DENY(chnil) of channeg1(chnil)
  | HOLD(ss_client) of channeg1(chnil)
  | GRANT(chnil) of (channeg1(ss_grant))
//
datatype
AgentGrantOpt(ss:vtype) = RETURN1(chnil) of ()

(* ****** ****** *)
//
extern
fun
chanref_recv
  {a:vtype}(chan: chanref(a)): (a)
extern
fun
chanref_send
  {a:vtype}(chan: chanref(a), x: (a)): void
//
(* ****** ****** *)
//
extern
fun
chanptr_recv
  {a:vtype}(chan: !chanptr(a)): (a)
extern
fun
chanptr_send
  {a:vtype}(chan: !chanptr(a), x: (a)): void
//
(* ****** ****** *)
//
extern
fun
channeg1_client{ss:vtype}
  (chan: !channeg1(ss_client) >> channeg1(ss), x: ClientOpt(ss)): void
extern
fun
chanpos1_client
  (chan: !chanpos1(ss_client) >> chanpos1(ss)): #[ss:vtype] ClientOpt(ss)
//
(* ****** ****** *)
//
extern
fun
channeg1_grant{ss:vtype}
  (chan: !channeg1(ss_grant) >> channeg1(ss), x: AgentGrantOpt(ss)): void
extern
fun
chanpos1_grant
  (chan: !chanpos1(ss_grant) >> chanpos1(ss)): #[ss:vtype] AgentGrantOpt(ss)
//
(* ****** ****** *)









////

(* ****** ****** *)

fun pml$init (): void = let
  val _ = pml$run (proctype$foo ())
  val _ = pml$run (proctype$foo2 ())
in end

