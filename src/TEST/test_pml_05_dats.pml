
// Header in Promela

#define get_pid() _pid

// End of header


int g = 3;
int g2 = 4;
#define pml_get_g() g + 1
inline pml_set_g(x) {
  g = x;
}

init {
  int x_1;
  int y_3;
  x_1 = pml_get_g();
  y_3 = (x_1) + (1);
  pml_set_g(y_3)
}

