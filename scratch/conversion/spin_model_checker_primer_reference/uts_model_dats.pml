
// model of uts

#define N 3 /* nr of processes */

mtype = {Wakeme, Running };  /* process states */

/* *********** ************* */

// Manually constructed
bit r_lock;
#define r_lock_get ()  r_lock
#define r_lock_set (b) r_lock = b

// Manually constructed
bit r_wanted;
#define r_wanted_get ()  r_wanted
#define r_wanted_set (b) r_wanted = b

/* *********** ************* */

// Manually constructed
bit lk;    /* lock for resource */

#define freelock(x) x = 0
#define waitlock(x) (x == 0)
#define spinlock(x) atomic {waitlock(x) -> x = 1}

/* *********** ************* */

// Manually constructed
bit sq;    /* lock for process states */
#define freelock_sq() sq = 0
#define spinlock_sq() atomic {waitlock(sq) -> sq = 1}

/* *********** ************* */

// Manually constructed
mtype pstate[N] = Running;

#define pstate_get(i) pstate[i]
#define pstate_set(i, x) pstate[i] = x
#define pstate_set_no_lock(i, x) pstate[i] = x

/* *********** ************* */

inline wakeup_loop(i) {
  int i_wakeup_loop = i;
  do
  :: i_wakeup_loop < N ->
    if 
    :: pstate_get(i_wakeup_loop) == Wakeme ->
        pstate_set(i_wakeup_loop, Running);
        i_wakeup_loop++;
    :: else -> i_wakeup_loop++
    fi
  :: else -> break
  od
}
    

inline wakeup() {
    spinlock_sq();
    wakeup_loop(0);
    freelock_sq();
}

inline sleepl(y, x) {
    spinlock(sq);
    freelock(x);
    pstate[_pid] = Wakeme;
    freelock(sq);
    (pstate[_pid] == Running);
    spinlock(x)
}

inline user_loop_loop2() {
  if 
  :: r_lock_get() -> 
        r_wanted_set(1); 
        sleepl(i, lk);
  :: else -> break
}

inline user_loop() {
  do
  ::
    spinlock(lk);
    loop2();

    r_lock_set(1);
    freelock(lk);
R:  
    r_lock_set(0);
    waitlock(lk);
    if
    :: r_wanted_get() ->
          r_wanted_set(0);
          waitlock(lk);
          wakeup();
    :: else
    fi
  :: else
  od
}

inline myuser(i) {
  user_loop();
}
  

active [N] proctype user()
{
    pid i;
    do
    :: spinlock(lk)
        do
        :: r_lock -> 
                r_wanted = 1;
                sleepl(_, lk)
                // rzq: How can we prove that this user
                // will be waken up?
        :: else -> break
        od;
        
        r_lock = 1;
        freelock(lk);

R:        /* use resource r */

        r_lock = 0;
        waitlock(lk);  // rzq: This line is not necessary. It
                         // has no effect on the result.
        if
        :: r_wanted ->
            r_wanted = 0;
#ifdef FIX
            waitlock(lk);
         // atomic{spinlock(lk);freelock(lk);}
         // rzq: If we use spinlock and freelock to enclose
         // the if...fi block, then this case is similar to
         // a normal user case of "condition" with signal.
#endif
            wakeup();
         // The essence is that the wakeup should take place after
         // the corresponding sleepl.
        :: else
        fi
    od
}


#define p (pstate[0] == Wakeme)
#define q (user[1]@R)
#define r (user[2]@R)

        

