

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

proctype foo1_0(int x_1) {
  printf("pid is %d in foo1", get_pid())
}
init {
atomic {
  pid pid1_4;
  printf("pid is %d in init", get_pid());
  pid1_4 = run foo1_0(1)
}
}

