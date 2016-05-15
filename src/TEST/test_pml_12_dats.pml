
// Header in Promela

#define get_pid() _pid

// End of header

proctype foo1_0(int x_1) {
  printf("pid is %d in foo1", get_pid())
}
init {
  int pid1_4;
  printf("pid is %d in init", get_pid());
  pid1_4 = run foo1_0(1)
}

