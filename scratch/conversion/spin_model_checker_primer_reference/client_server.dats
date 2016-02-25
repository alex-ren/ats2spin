/*
  Author: Zhiqiang Ren
  Date started: 02/19/2016
  Desc: Translation of client_server.pml
*/
staload "../Promela.sats"
staload UNSAFE = "prelude/SATS/unsafe.sats"

#define N 2

datatype mtype = 
| request
| deny
| hold
| grant
| return0

//

datasort typelist =
| nil
| cons of (t@ype, typelist)

sortdef tylst = typelist

#define :: cons

//

abstype chan (n: int, ts: tylst)
typedef chan0 (ts: tylst) = chan (0, ts)
typedef chan0_1 (a: t@ype) = chan0 (a::nil)
typedef chan0_2 (a,b: t@ype) = chan0 (a::b::nil)

typedef chann_1 (n: int, a:t@ype) = chan (n, a :: nil)
typedef Chann_1 (a:t@ype) = [n:nat] chann_1 (n, a)

typedef chann_2 (n: int, a,b:t@ype) = chan (n, a :: b :: nil)
typedef Chann_2 (a,b:t@ype) = [n:nat] chann_2 (n, a, b)

extern fun chan_isempty {n:nat} {ts:tylst} (chan (n, ts)): bool

extern fun chann_1_send {a:t@ype} (
  ch: Chann_1 (a),
  x: a
): bool

extern fun chann_1_recv {a:t@ype} (
  ch: Chann_1 (a),
  x: &a? >> a
): bool

extern fun chann_2_send {a,b:t@ype} (
  ch: Chann_2 (a, b),
  x0: a,
  x1: b
): bool

extern fun chann_1_recvm {a:t@ype} (
  ch: Chann_1 (a),
  x: a
): bool

extern fun chann_2_recvm0 {a,b:t@ype} (
  ch: Chann_2 (a, b),
  x: a,
  y: & b? >> b
): bool

//
abstype array (a:t@ype, sz: int)

extern fun array_get {a:t@ype} {n,sz:nat | n < sz} (
  arr: array (a, sz),
  n: int n
): a

extern fun array_set {a:t@ype} {n,sz:nat | n < sz} (
  arr: array (a, sz),
  n: int n,
  x: a
): void


fun test (): void = let
  var x: [i:nat] int i = 3

  extern fun foo {i:nat | i < 3} (i: int i): void

  val () = if true then (x := 1; foo (x))
  else (x := 2; foo (x))
  
  // todo: how to make the following type checking
  val () = foo (x)
in
end

// fun test2 (): void = let
//   // fun foo {x:int} (x: !int x >> int 3): void = let
//   //   extern fun cast {x:int} (x: !int x >> int 3): void
//   //   val () = cast (x)
//   // in end
//   extern fun foo {x:int} (x: !int x >> int 3): void
//   
//   fun foo2 (x: int 3): void = ()
//   val x = 1
//   val () = foo (x)
//   val () = foo2 (x)
// in end

extern val server: chan0_2 (mtype, [ts:tylst] chan0 (ts))

//

fun proctype_agent (
  listen: chan0_1 (mtype), 
  talk: chan0_2 (mtype, chan0_1 (mtype))
): process_end = let
  fun loop (): void =
  case- true (*non-deterministic*) of
  | _ when chann_2_send (talk, hold, listen) => ()
  | _ when chann_2_send (talk, deny, listen) => ()
  | _ when chann_2_send (talk, grant, listen) => let
    prval () = Promela$set_tag ("wait")
    val _ = chann_1_recvm (listen, return0)
  in () end
  
  val () = loop ()
  val _ = chann_2_send (server, return0, listen)
in Promela$process_end () end

// #codegen_promela("r0", chan1)

extern prfun Promela$default_init {a:t@ype} (
  x: &a? >> a): void

// todo: Why need the following?
extern prfun Promela$default_init2 {a:type} (
  x: &a? >> a): void

fun proctype_server (pid: pid): process_end = let
  var agents: array (chan0_1 (mtype), N)?
  prval () = Promela$default_init2 (agents)

  var pool: chann_1 (N, chan0_1 (mtype))?
  prval () = Promela$default_init (pool)
  
  var client: chan0_2 (mtype, chan0_1 (mtype))?
  var agent: chan0_1 (mtype)?

  fun loop1 {i:nat | i <= N} (
    i: int i, /* todo: use byte */
    pool: &(chann_1 (N, chan0_1 (mtype))),
    agents: array (chan0_1 (mtype), N)
  ): void = 
    if i < N then let
      val _ = chann_1_send (pool, array_get (agents, i))
    in loop1 (i + 1, pool, agents) end
    else ()
    val () = loop1 (0, pool, agents)


  extern prfun uninitialize {a:t@ype} (x: &a >> a?): void

  fun loop2 (
    agents: array (chan0_1 (mtype), N),
    pool: chann_1 (N, chan0_1 (mtype)),
    client: & chan0_2 (mtype, chan0_1 (mtype))? >>
              chan0_2 (mtype, chan0_1 (mtype)),
    agent: &chan0_1 (mtype)?
  ): process_end =
  (
  case- true (*non-deterministic*) of
  | _ when chann_2_recvm0 (server, request, client) => let
    // todo Can we use datatype for message? Or session type?
    extern prfun cast {ts:tylst} (x: &chan0 ts >> 
                   chan0_2 (mtype, chan0_1 (mtype))): void
    prval () = cast (client)
  in
    if chan_isempty (pool) then let
      val _ = chann_2_send (client, deny, $UNSAFE.cast(0))
      prval () = uninitialize {chan0_2 (mtype, chan0_1 (mtype))}(client)
    in 
      loop2 (agents, pool, client, agent)
    end else let
      val _ = chann_1_recv {chan0_1 (mtype)} (pool, agent)
      // todo
      // val x = agent
      // val y = client
      // val () = Promela$run (lam () => proctype_agent (x, y))
      val () = Promela$run2 (proctype_agent (agent, client))
    
      prval () = uninitialize {chan0_2 (mtype, chan0_1 (mtype))}(client)
      prval () = uninitialize {chan0_1 (mtype)} (agent)
    in
      loop2 (agents, pool, client, agent)
    end
  end
  | _ when chann_2_recvm0 (server, return0, agent) => let
    extern prfun cast {ts:tylst} (x: &chan0 ts >> 
                 chan0_1 (mtype)): void
    prval () = cast (agent)
    val _ = chann_1_send (pool, agent)
    prval () = uninitialize {chan0_1 (mtype)} (agent)
  in
    loop2 (agents, pool, client, agent)
  end
  )

in
  loop2 (agents, pool, client, agent)
end

  
  
  

    
