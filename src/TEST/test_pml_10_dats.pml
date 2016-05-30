
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline fact_0(x_12, res_11) {
  int x_1;
  int res_2;
  int x_14;
  int res_15;
  x_1 = x_12;
  res_2 = res_11;
  fact_13:
  if 
  :: (x_1) > (0) -> 
    x_14 = (x_1) - (1);
    res_15 = (x_1) * (res_2);
    x_1 = x_14;
    res_2 = res_15;
    goto fact_13
  :: else  -> 
    printf("ans = %d", res_2)
  fi
}
inline fact2_6(x_7, res_8) {
  if 
  :: (x_7) > (0) -> 
    fact_0((x_7) - (1), (x_7) * (res_8))
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_10;
  x_10 = 5;
  fact2_6(x_10, 1)
}
}

