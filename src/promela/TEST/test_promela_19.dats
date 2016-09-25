

#include "share/HATS/atspre_staload_libats_ML.hats"
staload "./Promela.sats"


(* ****** ****** *)

abstype chanref(a:vt@ype)

(* ****** ****** *)

absvtype chanptr(a:vt@ype)

(* ****** ****** *)
// Can transfer any type of payload
absvtype channel0
//
absvtype chanpos1(ss:vt@ype)
absvtype channeg1(ss:vt@ype)

(* ************** ************** *)

// End state of channels
abstype chnil

(* ************** ************** *)

extern
fun
channel0_split {init:vt@ype}
  (chan: !channel0 >> chanpos1(init)): channeg1(init)
//
(* ****** ****** *)
//
extern
prfun
channeg1_nil_close (channeg1(chnil)): void
extern
prfun
chanpos1_nil_close (!chanpos1(chnil) >> channel0): void

(* ************** ************** *)
//
// States of protocals

absvtype ss_client

absvtype ss_grant


(* ************** ************** *)
// Protocals

// Channel for send to Client
datavtype
ClientOpt(start:vt@ype, next:vt@ype) =
  | DENY(ss_client, chnil) of ()
  | HOLD(ss_client, ss_client) of ()
  | GRANT(ss_client, chnil) of (channeg1(ss_grant))

extern
fun
pml_chan_send$channeg1_client{beg,next:vt@ype}
  (chan: !channeg1(beg) >> channeg1(next), x: ClientOpt(beg, next)): void
extern
fun
pml_chan_recv$chanpos1_client {beg:vt@ype}
  (chan: !chanpos1(beg) >> chanpos1(next)): #[next:vt@ype] ClientOpt(beg,next)

(* ************** ************** *)
// Channel for send to Agent
datavtype
AgentOpt(start:vt@ype, next:vt@ype) =
| RETURN(ss_grant, chnil) of ()

vtypedef AgentOpt = [s,n:vt@ype] AgentOpt (s, n)

extern
fun
pml_chan_send$channeg1_agent{beg,next:vt@ype}
  (chan: !channeg1(beg) >> channeg1(next), x: AgentOpt(beg, next)): void
extern
fun
pml_chan_recv$chanpos1_agent {beg:vt@ype}
  (chan: !chanpos1(beg) >> chanpos1(next)): #[next:vt@ype] AgentOpt(beg,next)

(* ************** ************** *)
// Channel for send to Server
datavtype
ServerOpt =
  | RETURN of (channel0)
  | REQUEST of (channeg1(ss_client))

//

(* **************** **************** *)

// create local channels
// ATS/PML compiler shall generate the body of this function in PML.
extern fun pml_chan_create$
  {a:vt@ype}(*type of payload*) {b:vt@ype} (*type of channel*) (
  int (*buffer size, must be constant when invoked*)
  ): b

// Patterns for operations are similar,
// but types for operations can be very sophisticated.
extern fun pml_chan_recv$
  {pt:vt@ype} {b:vt@ype} (ch: !b): pt

extern fun pml_chan_send$
  {pt:vt@ype} {b:vt@ype} (ch: !b, ele: pt): void

extern fun pml_chan_isempty$ {a:vt@ype} (ch: !a): bool

extern fun pml_chan_isnotempty$ {a:vt@ype} (ch: !a): bool

extern prfun pml_chan_destroy$ {a:vt@ype} (ch: a): void

(* **************** **************** *)

abstype array_t

extern fun pml_array_create$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  int (*array size, must be constant when invoked*)
  , ele: a // initial value
  ): b

extern fun pml_array_get$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  arr: !b
  , n: int
  ): a

extern fun pml_array_set$
  {a: vt@ype (*type of element*)} {b:vt@ype} (
  arr: !b
  , ele: a
  , n: int
  ): void
(* **************** **************** *)
// Must input static arguments. Otherwise may cause type checking failure.
val theServer = pml_chan_create${ServerOpt} {chanref ServerOpt} (2) 

extern fun proctype$agent (
  agent: channel0, client: channeg1 (ss_client)): void

#define N 2
fun proctype$server (): void = let
  val agents = pml_array_create$
               {channel0}{array_t} 
               (N, pml_chan_create${AgentOpt}{channel0} (0))

fun inline$loop (n: &int, arr: !array_t, pool: !chanptr (channel0)): void =
if n < N then let
  val () = pml_chan_send$ (pool
                    , pml_array_get${channel0} {array_t} (arr, n))
in end


fun inline$loop (pool: &chanptr(channel0)): void = 
case pml$random of
| 0 => (case- pml_chan_recv$ {ServerOpt} {chanref ServerOpt} (theServer) 
  of ~RETURN (agent) => let
  val () = pml_chan_send$ (pool, agent)
in end
)
| 1 => (case- pml_chan_recv$ {ServerOpt} {chanref ServerOpt} (theServer) 
  of ~REQUEST (client) =>
  if pml_chan_isnotempty$ (pool) then
    case- pml_chan_recv$ {channel0} (pool) of
    | agent => let
      val _ = pml$run (proctype$agent (agent, client))
    in inline$loop (pool) end
  else let
    val () = pml_chan_send$channeg1_client (client, DENY ())
    prval () = channeg1_nil_close (client)
  in inline$loop (pool) end
)
in end

// Use tuple in ATS for typedef in PROMELA
// Currently I don't want to fully support the pattern match in ATS/PML.
// I.E. certain pattern match cannot be mapped to valid PROMELA.
// Then the question is to what extent do I support.
// val- (1, x) = recv () when x = y
// val- Cons (2, x) = recv () when x = y
// The payload can be an instance of certain datatype (members of
// this datatype cannot have compound types (e.g. datatype, array)
// or a sequence of elementary types (e.g. int).







////

(* ****** ****** *)

fun pml$init (): void = let
  val _ = pml$run (proctype$foo ())
  val _ = pml$run (proctype$foo2 ())
in end

