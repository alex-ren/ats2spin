
staload "./Promela.sats"

(* ****** ****** *)

abstype chanref(a:vt@ype) = pml$chan  // type in PROMELA

(* ****** ****** *)

absvtype chanptr(a:vt@ype) = pml$chan  // type in PROMELA

(* ****** ****** *)
// Can transfer any type of payload
absvtype channel0 = pml$chan  // type in PROMELA
//
absvtype chanpos1(ss:vt@ype) = pml$chan  // type in PROMELA
absvtype channeg1(ss:vt@ype) = pml$chan  // type in PROMELA

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

vtypedef ClientOpt = [s,n:vt@ype] ClientOpt (s, n)

extern
fun
pml$chan_send$channeg1_client{beg,next:vt@ype}
  (chan: !channeg1(beg) >> channeg1(next), x: ClientOpt(beg, next)): void
extern
fun
pml$chan_recv$chanpos1_client {beg:vt@ype}
  (chan: !chanpos1(beg) >> chanpos1(next)): #[next:vt@ype] ClientOpt(beg,next)

(* ************** ************** *)
// Channel for send to Agent
datavtype
AgentOpt(start:vt@ype, next:vt@ype) =
| RETURN(ss_grant, chnil) of ()

vtypedef AgentOpt = [s,n:vt@ype] AgentOpt (s, n)

extern
fun
pml$chan_send$channeg1_agent{beg,next:vt@ype}
  (chan: !channeg1(beg) >> channeg1(next), x: AgentOpt(beg, next)): void
extern
fun
pml$chan_recv$chanpos1_agent {beg:vt@ype}
  (chan: !chanpos1(beg) >> chanpos1(next)): #[next:vt@ype] AgentOpt(beg,next)

(* ************** ************** *)
// Channel for send to Server
datavtype
ServerOpt =
  | RETURN of (channel0)
  | REQUEST of (channeg1(ss_client))

//

(* **************** **************** *)

abstype chan_array = pml$array (pml$chan)  // type in PROMELA

(* **************** **************** *)
extern fun pml$timeout (): bool

%{
#define timeout (_nr_pr <= N + M)
%}

(* **************** **************** *)

// Must input static arguments. Otherwise may cause type checking failure.
val server = pml$chan_create${ServerOpt} {chanref ServerOpt} (0) 

fun proctype$agent (
  agent: channel0, client: channeg1 (ss_client)): void = let

fun inline$loop (agent: !channel0, client: channeg1 (ss_client)): void =
case+ pml$random of
| 0 => let
  val () = pml$chan_send$channeg1_client (client, HOLD ())
in
  inline$loop (agent, client)
end
| 1 => let
  val () = pml$chan_send$channeg1_client (client, DENY ())
  prval () = channeg1_nil_close (client)
in
  // cannot call inline$loop (agent, client) again
  // the status of client has changed
end
| 2 => let
  val () = pml$chan_send$channeg1_client (
             client, GRANT (channel0_split {ss_grant} (agent)
))
in
  case- pml$chan_recv$chanpos1_agent (agent) of
  | ~RETURN () => let
    prval () = chanpos1_nil_close (agent)
    prval () = channeg1_nil_close (client)
  in end
end

val () = inline$loop (agent, client)
val () = pml$chan_send$ {ServerOpt}{chanref ServerOpt} (server, RETURN (agent))
in end

(* ****************** ****************** *)

#define N 2
fun proctype$server (): void = let

val agents = pml$array_create$
             {channel0}{chan_array} 
             (N, pml$chan_create${AgentOpt}{channel0} (0))

var pool = pml$chan_create$ {channel0} {chanptr (channel0)} (N)

fun inline$loop_init (n: int, pool: &chanptr (channel0)): void =
if n < N then let
  val ele = pml$array_get$ {channel0} {chan_array} (agents, n)
  val () = pml$chan_send$ (pool, ele)
in 
  inline$loop_init (n + 1, pool) 
end

val () = inline$loop_init (0, pool)

fun inline$loop (pool: &chanptr(channel0) >> (chanptr(channel0))?): void = 
case pml$random of
| 0 => (case- pml$chan_recv$ {ServerOpt} {chanref ServerOpt} (server) 
  of ~RETURN (agent) => let
  val () = pml$chan_send$ (pool, agent)
in inline$loop (pool) end
)
| 1 => (case- pml$chan_recv$ {ServerOpt} {chanref ServerOpt} (server) 
  of ~REQUEST (client) =>
  case+ pml$random of
  | 0 => let
    val () = pml$wait_until0$ (pml$chan_isempty$ (pool))
    val () = pml$chan_send$channeg1_client (client, DENY ())
    prval () = channeg1_nil_close (client)
  in inline$loop (pool) end
  | 1 => let
    val () = pml$wait_until0$ (pml$chan_isnotempty$ (pool))
  in
    case- pml$chan_recv$ {channel0} (pool) of
    | agent => let
      val _ = pml$run (proctype$agent (agent, client))
    in inline$loop (pool) end
  end
)

in 
  inline$loop (pool)
end

(* ****************** ****************** *)

fun proctype$client (): void = let
val me = pml$chan_create${ClientOpt}{channel0} (0)

fun inline$loop1 (me: channel0): void = let
  val () = pml$wait_until0 (lam () => pml$timeout ())
  val () = pml$chan_send$ {ServerOpt} {chanref ServerOpt} (
      server, REQUEST (channel0_split (me)))

  fun inline$loop2 (me: !chanpos1 (ss_client) >> chanpos1 (chnil)): void =
    case+ pml$random of
    | 0 => (case- pml$chan_recv$chanpos1_client{ss_client} (me) of
           | ~HOLD () => inline$loop2 (me)
           )
    | 1 => (case- pml$chan_recv$chanpos1_client (me) of
           | ~DENY () => ()  // break
           )
    | 2 => (case- pml$chan_recv$chanpos1_client (me) of
           | ~GRANT (agent) => let
             val () = pml$chan_send$channeg1_agent (agent, RETURN ())
             prval () = channeg1_nil_close (agent)
           in end  // break
           )

  val () = inline$loop2 (me)

  prval () = chanpos1_nil_close (me)
in
  inline$loop1 (me)
end

in
  inline$loop1 (me)
end



(* ****************** ****************** *)

// Use tuple in ATS for typedef in PROMELA
// Currently I don't want to fully support the pattern match in ATS/PML.
// I.E. certain pattern match cannot be mapped to valid PROMELA.
// Then the question is to what extent do I support.
// val- (1, x) = recv () when x = y
// val- Cons (2, x) = recv () when x = y
// The payload can be an instance of certain datatype (members of
// this datatype cannot have compound types (e.g. datatype, array)
// or a sequence of elementary types (e.g. int).





