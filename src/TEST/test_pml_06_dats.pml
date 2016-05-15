
// Header in Promela

#define get_pid() _pid

// End of header

inline foo_0(x_1) {
  int y_2;
  y_2 = (x_1) + (1)
}
init {
  foo_0(2);
  foo_0(2)
}

