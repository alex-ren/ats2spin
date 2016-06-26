
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

inline foo_0(x_1) {
  int y_2;
  y_2 = (x_1) + (1);
  x_1 = ((y_2) * (y_2)) + (1)
}
init {
atomic {
  int y_4;
  int x_5;
  x_5 = 2;
  printf("old x is %d", x_5);
  foo_0(x_5);
  printf("new x is %d", x_5)
}
}

