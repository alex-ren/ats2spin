

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header


int g = 3;
int g2 = 4;
#define pml_get_g() g + 1
inline pml_set_g(x) {
  g = x;
}

init {
atomic {
  int x_1;
  int y_3;
  x_1 = pml_get_g();
  y_3 = (x_1) + (1);
  pml_set_g(y_3)
}
}

