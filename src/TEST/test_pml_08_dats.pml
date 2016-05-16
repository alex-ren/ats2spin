
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0(x_9, y_8) {
  int x_1;
  int y_2;
  int y_3;
  int x_11;
  int y_12;
  x_1 = x_9;
  y_2 = y_8;
  foo_10:
  y_3 = (x_1) + (1);
  printf("y is %d ", y_3);
  if 
  :: (y_3) < (4) -> 
    x_11 = y_3;
    y_12 = x_1;
    x_1 = x_11;
    y_2 = y_12;
    goto foo_10
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_7;
  x_7 = 1;
  foo_0(x_7, 2)
}
}

