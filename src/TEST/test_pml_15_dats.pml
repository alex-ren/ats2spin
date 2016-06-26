
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0(n_5, x_2) {
  int n_1;
  int n_7;
  int x_8;
  n_1 = n_5;
  foo_6:
  if 
  :: (n_1) > (0) -> 
    x_2 = (n_1) * (x_2);
    n_7 = (n_1) - (1);
    x_8 = x_2;
    n_1 = n_7;
    x_2 = x_8;
    goto foo_6
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_4;
  x_4 = 1;
  printf("old x is %d\n", x_4);
  foo_0(4, x_4);
  printf("new x is %d\n", x_4)
}
}

