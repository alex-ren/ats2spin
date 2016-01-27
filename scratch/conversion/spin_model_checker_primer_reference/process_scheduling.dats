
staload "../Promela.sats"

#define N 3

#define Wakeme 0
#define Running 1

stacst r_lock: gname


absview lock_v (n: gname)

extern fun freelock {lk: gname} (lock_v (lk)): void
extern fun waitlock {lk: gname} (): (lock_v (lk) | void)


