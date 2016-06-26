
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0(x_7, y_6) {
  int x_1;
  int y_2;
  int y_3;
  int x_9;
  int y_10;
  x_1 = x_7;
  y_2 = y_6;
  foo_8:
  y_3 = (x_1) + (1);
  printf("y is %d ", y_3);
  if 
  :: (y_3) < (4) -> 
    x_9 = y_3;
    y_10 = x_1;
    x_1 = x_9;
    y_2 = y_10;
    goto foo_8
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_5;
  x_5 = 1;
  foo_0(x_5, 2)
}
}

