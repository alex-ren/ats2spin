
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0(n_9, x_8) {
  int n_1;
  int x_2;
  int n_11;
  int x_12;
  n_1 = n_9;
  foo_10:
  if 
  :: (n_1) > (0) -> 
    x_8 = (n_1) * (x_8);
    n_11 = (n_1) - (1);
    n_1 = n_11;
    goto foo_10
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_7;
  x_7 = 1;
  printf("old x is %d\n", x_7);
  foo_0(4, x_7);
  printf("new x is %d\n", x_7)
}
}

