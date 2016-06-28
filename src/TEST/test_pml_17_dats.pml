

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0() {
  int x_1;
  foo_7:
  x_1 = 1;
  if 
  :: atsbool_true -> 
    printf("this is branch 1\n");
    goto foo_7
  :: atsbool_true -> 
    printf("this is branch 2\n");
    goto foo_7
  :: else  -> 
    printf("this is branch end\n")
  fi
}
proctype foo_4() {
  foo_0()
}
init {
atomic {
  run foo_4()
}
}

