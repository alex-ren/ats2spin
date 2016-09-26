/*
 * This is the content I plan to generate from the ATS/PML model.
 *
*/

#define N 2

mtype = { request, deny, hold, grant, return0 };

chan server = [0] of { mtype, chan };


#define channel0_split(agent) agent

inline loop_agent(agent0, client0) {
  chan agent1;
  chan client1;
  agent1 = agent0;
  client1 = client0;
  start:
  if
  :: client1!hold(0) -> goto start
  :: client1!deny(0) ->  
  :: client1!grant(channel0_split(agent1));
     agent1?return0;
  fi
}


proctype Agent(chan agent; chan client)
{
  loop_agent(agent, client);
  server!return0(agent)
}

// ======================================

inline loop_init (n0, pool0) {
  int n;
  chan ele;
  n = n0;
  start:
  if
  :: n < N -> 
     ele = agents[n]; 
     pool!ele; 
     n = n + 1;
     goto start
  :: else ->
  fi
}


inline loop_server(pool) {
  chan agent;
  chan client;

  start:
  if
  :: server?return0(agent) ->
     pool!agent;
     goto start
  :: server?request(client) ->
     if
     :: empty(pool) ->
        client!deny(0);
        goto start
     :: nempty(pool) ->
        pool?agent;
        _ = run Agent(agent, client);
        goto start
     fi;
  fi
}


active proctype Server() {
  chan agents[N] = [0] of {mtype};
  chan pool = [N] of {chan};
  
  loop_init(0, pool);
  loop_server (pool)
}

// ======================================

#define M 2

#define timeout() (_nr_pr <= N + M)

inline client_loop2(me0) {
  chan me2;
  chan agent;

  me2 = me0;

  start_loop2:
  if
  :: me2?hold(agent) -> goto start_loop2
  :: me2?deny(agent) ->
  :: me2?grant(agent) -> agent!return0
  fi
}


inline client_loop1(me0) {
  chan me1;
  me1 = me0;

  start_loop1:
  timeout();
  server!request(me1);
  client_loop2(me1);
  goto start_loop1
}

active [M] proctype Client() {
chan me = [0] of {mtype, chan};

client_loop1(me);
}





