
#define NPHIL 5

// Manual input:

bool fork_arr[NPHIL] = 0

inline fork_acquire(n) {
  atomic {
  fork_arr[n] == 0; fork_arr[n] = 1;
  }
}

inline fork_release (n) {
  fork_arr[n] = 0;
}

inline phil_eat(n) {
  skip;
}
  
// Generated:

#define phil_left(n)  n
#define phil_right(n) ((n + 1) % NPHIL)


inline phil_acquire_lfork(n) {
  fork_acquire(phil_left (n));
}
 
inline phil_release_lfork(n) {
  fork_release(phil_left (n));
}

inline phil_acquire_rfork(n) {
  fork_acquire(phil_right (n));
}

inline phil_release_rfork(n) {
  fork_release(phil_right (n));
}

inline phil_dine(n) {
  phil_acquire_lfork(n);
  phil_acquire_rfork(n);
  phil_eat(n);
  phil_release_rfork(n);
  phil_release_lfork(n);
}

inline phil_loop2(n) {
  do
    :: phil_dine(n);
  od
}
 
inline init_loop(c) {
  int c_ = c;
  do
  :: run phil(c_); int cprime = c_ + 1; 
     if
     :: cprime < NPHIL -> c_ = cprime;
     :: else -> break;
     fi
  od;
}

proctype phil(int n) {
  phil_loop2(n);
}

// This causes deadlock.
init {
  atomic {
    init_loop(0)
  }
}

// The following doesn't have deadlock.

// proctype phil_reverse(int n) {
//   phil_acquire_rfork(n);
//   phil_acquire_lfork(n);
//   phil_eat(n);
//   phil_release_lfork(n);
//   phil_release_rfork(n);
// }
  


// init {
//   int count = 0;
//   atomic {
//   do
//   :: count < NPHIL - 1 -> run phil(count); count = count + 1;
//   :: else -> run phil_reverse(count); break;
//   od;
//   }
// }


