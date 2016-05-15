
// Header in Promela

#define get_pid() _pid

// End of header

init {
  int x_1;
  x_1 = 2;
  assert((x_1) > (1))
}

