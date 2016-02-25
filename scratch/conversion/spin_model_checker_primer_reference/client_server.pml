#define N 2

mtype = { request, deny, hold, grant, return0 };

chan server = [0] of { mtype, chan };

proctype Agent(chan listen; chan talk)
{
    do
    :: talk!hold(listen)
    :: talk!deny(listen) -> break
    :: talk!grant(listen) ->
        wait:
        listen?return0; break
    od;
    server!return0(listen)
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


