
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo2_1(x_11, y_10) {
  int x_2;
  int y_3;
  int x_5;
  int y_6;
  int y_7;
  int x_14;
  int y_15;
  int x_4;
  int x_16;
  int y_17;
  x_5 = x_11;
  y_6 = y_10;
  foo2_13:
  y_7 = (y_6) + (1);
  printf("y is %d", y_7);
  if 
  :: (y_7) < (100) -> 
    x_14 = x_5;
    y_15 = y_7;
    x_2 = x_14;
    y_3 = y_15;
    goto foo1_12
  :: else  -> 
    
  fi;
  foo1_12:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_16 = x_4;
  y_17 = y_3;
  x_5 = x_16;
  y_6 = y_17;
  goto foo2_13
}
inline foo1_0(x_19, y_18) {
  int x_2;
  int y_3;
  int x_5;
  int y_6;
  int x_4;
  int x_22;
  int y_23;
  int y_7;
  int x_24;
  int y_25;
  x_2 = x_19;
  y_3 = y_18;
  foo1_20:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_22 = x_4;
  y_23 = y_3;
  x_5 = x_22;
  y_6 = y_23;
  goto foo2_21;
  foo2_21:
  y_7 = (y_6) + (1);
  printf("y is %d", y_7);
  if 
  :: (y_7) < (100) -> 
    x_24 = x_5;
    y_25 = y_7;
    x_2 = x_24;
    y_3 = y_25;
    goto foo1_20
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_9;
  x_9 = 1;
  foo1_0(x_9, 1)
}
}

