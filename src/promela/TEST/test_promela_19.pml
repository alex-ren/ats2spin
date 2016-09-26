/*
 * This is the content I plan to generate from the ATS/PML model.
 *
*/

#define N 2

mtype = { request, deny, hold, grant, return0 };

chan server = [0] of { mtype, chan };

proctype Agent(chan agent; chan client)
{
  loop_agent(agent, client);
  server!return0(agent)
}

#define channel0_split(agent) agent

inline loop_agent(agent, client) {
  chan agent0;
  chan client0;
  agent0 = agent;
  client0 = client;
  chan agent1;
  start:
  if
  :: client!hold(0) -> agent0 = agent0; client0 = client0; goto start
  :: client!deny(0) ->  
  :: client!grant(channel0_split(agent));
     agent?return0;
  fi
}

  

active proctype Server()
{
    chan agents[N] = [0] of { mtype };
    chan pool = [N] of { chan };
    chan client, agent;
    byte i;
    do
    :: i < N -> pool!agents[i]; i++
    :: else -> break
    od;
    end:
    do
    :: server?request(client) ->
        if
        :: empty(pool) ->
            client!deny(0)
        :: nempty(pool) ->
            pool?agent;
            run Agent(agent,client)
        fi
    :: server?return0(agent) ->
        pool!agent
    od
}

#define timeout (_nr_pr <= N + M)

#define M 2
active [M] proctype Client()
{
    chan me = [0] of { mtype, chan };
    chan agent;
end:
    do
    :: timeout ->
        server!request(me);
        do
        :: me?hold(agent)
        :: me?deny(agent) -> break
        :: me?grant(agent) -> agent!return0; break
        od
    od
}


