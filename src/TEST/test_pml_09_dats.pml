
// Header in Promela

#define get_pid() _pid

// End of header

inline foo2_1(x_13, y_12) {
  int x_2;
  int y_3;
  int x_6;
  int y_7;
  int y_8;
  int x_16;
  int y_17;
  int x_4;
  int x_18;
  int y_19;
  x_6 = x_13;
  y_7 = y_12;
  foo2_15:
  y_8 = (y_7) + (1);
  printf("y is %d", y_8);
  if 
  :: (y_8) < (100) -> 
    x_16 = x_6;
    y_17 = y_8;
    x_2 = x_16;
    y_3 = y_17;
    goto foo1_14
  :: else  -> 
    
  fi;
  foo1_14:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_18 = x_4;
  y_19 = y_3;
  x_6 = x_18;
  y_7 = y_19;
  goto foo2_15
}
inline foo1_0(x_21, y_20) {
  int x_2;
  int y_3;
  int x_6;
  int y_7;
  int x_4;
  int x_24;
  int y_25;
  int y_8;
  int x_26;
  int y_27;
  x_2 = x_21;
  y_3 = y_20;
  foo1_22:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_24 = x_4;
  y_25 = y_3;
  x_6 = x_24;
  y_7 = y_25;
  goto foo2_23;
  foo2_23:
  y_8 = (y_7) + (1);
  printf("y is %d", y_8);
  if 
  :: (y_8) < (100) -> 
    x_26 = x_6;
    y_27 = y_8;
    x_2 = x_26;
    y_3 = y_27;
    goto foo1_22
  :: else  -> 
    
  fi
}
init {
  int x_11;
  x_11 = 1;
  foo1_0(x_11, 1)
}

