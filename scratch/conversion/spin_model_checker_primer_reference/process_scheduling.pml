
// model of uts

#define N 3 /* nr of processes */

mtype = {Wakeme, Running };  /* process states */

mtype pstate[N] = Running;

bit r_lock;
bit r_wanted;  /* resource state */
bit lk, sq;    /* locks */

#define freelock(x) x = 0
#define waitlock(x) (x == 0)
#define spinlock(x) atomic {waitlock(x) -> x = 1}

inline wakeup(x) {
    spinlock(sq);
    i = 0;
    do
    :: i < N -> if
                :: pstate[i] == Wakeme ->
                   pstate[i] = Running; 
                   i++  // This line doesn't exist in the book.
                :: else -> i++
                fi
    :: else -> break
    od;

    freelock(sq)
}

inline sleepl(y, x) {
    spinlock(sq);
    freelock(x);
    pstate[_pid] = Wakeme;
    freelock(sq);
    (pstate[_pid] == Running);
    spinlock(x)
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
            wakeup(_);
         // The essence is that the wakeup should take place after
         // the corresponding sleepl.
        :: else
        fi
    od
}


#define p (pstate[0] == Wakeme)
#define q (user[1]@R)
#define r (user[2]@R)

        

