

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline loop_4(c_5, s_6) {
  skip;
  loop_10:
  s_6 = (s_6) + (c_5);
  c_5 = (c_5) + (1);
  if 
  :: (c_5) > (x_1) -> 
    
  :: else  -> 
    goto loop_10
  fi
}
proctype foo_0(int x_1) {
  int count_2;
  int sum_3;
  count_2 = 0;
  sum_3 = 0;
  loop_4(count_2, sum_3);
  printf("sum is %d\n", sum_3);
  assert((sum_3) == (10))
}
init {
atomic {
  _ = run foo_0(4)
}
}

