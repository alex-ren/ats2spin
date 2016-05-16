
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header


int g = 0;

#define g_get() g

inline g_set(x) {
  g = x;
}

proctype foo1_0(int x_1) {
  int y_3;
  printf("g is %d in foo1", g_get());
  y_3 = g_get();
  g_set((x_1) + (y_3))
}
proctype foo2_6() {
  (g_get()) > (0);
  printf("g is %d in foo2", g_get())
}
init {
atomic {
  int pid1_10;
  int pid2_12;
  pid1_10 = run foo1_0(1);
  pid2_12 = run foo2_6()
}
}

