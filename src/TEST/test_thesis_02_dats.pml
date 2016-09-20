

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline incy_5(x2_8, y2_9) {
  skip;
  incy_13:
  y2_9 = (y2_9) + (1);
  goto incx_12;
  incx_12:
  if 
  :: (x2_8) > (n_1) -> 
    
  :: else  -> 
    x2_8 = (x2_8) + (1);
    goto incy_13
  fi
}
inline incx_4(x1_6, y1_7) {
  skip;
  incx_14:
  if 
  :: (x1_6) > (n_1) -> 
    
  :: else  -> 
    x1_6 = (x1_6) + (1);
    goto incy_15
  fi;
  incy_15:
  y1_7 = (y1_7) + (1);
  goto incx_14
}
proctype foo_0(int n_1) {
  int x_2;
  int y_3;
  x_2 = 0;
  y_3 = 0;
  incx_4(x_2, y_3);
  printf("x is %d\n", x_2);
  printf("y is %d\n", y_3)
}
init {
atomic {
  _ = run foo_0(100)
}
}

