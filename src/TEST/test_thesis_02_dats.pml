

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline incy_5(x2_8, y2_9) {
  skip;
  incy_14:
  y2_9 = (y2_9) + (1);
  goto incx_13;
  goto incy_end_15;
  incx_13:
  if 
  :: (x2_8) > (n_1) -> 
    
  :: else  -> 
    x2_8 = (x2_8) + (1);
    goto incy_14
  fi;
  goto incy_end_15;
  incy_end_15:
}
inline incx_4(x1_6, y1_7) {
  skip;
  incx_16:
  if 
  :: (x1_6) > (n_1) -> 
    
  :: else  -> 
    x1_6 = (x1_6) + (1);
    goto incy_17
  fi;
  goto incx_end_18;
  incy_17:
  y1_7 = (y1_7) + (1);
  goto incx_16;
  incx_end_18:
}
proctype foo_0(int n_1) {
  int x_2;
  int y_3;
  x_2 = 0;
  y_3 = 0;
  incx_4(x_2, y_3);
  printf("x is %d\n", x_2);
  printf("y is %d\n", y_3);
  assert((x_2) == ((n_1) + (1)));
  assert((x_2) == (y_3))
}
init {
atomic {
  _ = run foo_0(40)
}
}

