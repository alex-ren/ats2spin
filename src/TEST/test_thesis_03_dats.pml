

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header



int g = 1;
#define get_g() g
inline get_g2(x) {
  x = g
}

inline set_g(x) {
  g = x
}


proctype foo_0() {
  int lg1_1;
  int lg2_3;
  lg1_1 = get_g();
  printf("g is %d\n", lg1_1);
  lg2_3 = 0;
  get_g2(lg2_3);
  assert((lg1_1) == (lg2_3));
  set_g((lg1_1) + (lg2_3))
}
init {
atomic {
  _ = run foo_0()
}
}

