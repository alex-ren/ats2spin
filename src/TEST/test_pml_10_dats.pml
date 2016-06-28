

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline fact_0(x_9, res_8) {
  int x_1;
  int res_2;
  int x_11;
  int res_12;
  x_1 = x_9;
  res_2 = res_8;
  fact_10:
  if 
  :: (x_1) > (0) -> 
    x_11 = (x_1) - (1);
    res_12 = (x_1) * (res_2);
    x_1 = x_11;
    res_2 = res_12;
    goto fact_10
  :: else  -> 
    printf("ans = %d", res_2)
  fi
}
inline fact2_3(x_4, res_5) {
  if 
  :: (x_4) > (0) -> 
    fact_0((x_4) - (1), (x_4) * (res_5))
  :: else  -> 
    
  fi
}
init {
atomic {
  int x_7;
  x_7 = 5;
  fact2_3(x_7, 1)
}
}

