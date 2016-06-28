

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0() {
  int x_1;
  x_1 = 1;
  if 
  :: atsbool_false -> 
    printf("this is branch 1\n")
  :: atsbool_true -> 
    printf("this is branch 2\n")
  :: else  -> 
    printf("this is branch else\n")
  fi
}
inline foo2_5() {
  int x_6;
  x_6 = 1;
  if 
  :: atsbool_false -> 
    printf("this is branch 1\n")
  :: atsbool_true -> 
    printf("this is branch 2\n")
  fi
}
proctype foo_7() {
  foo_0()
}
proctype foo2_8() {
  foo2_5()
}
init {
atomic {
  run foo_7();
  run foo2_8()
}
}

