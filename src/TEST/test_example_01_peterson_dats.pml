
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header


bool turn, flag[2];

#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n

int g_lock = 0;

#define vlock_acquire() \
d_step { \
assert(g_lock == 0); \
g_lock = 1; \
}

#define vlock_release() \
g_lock = 0



inline loop_10(i_27, j_26) {
  int i_11;
  int j_12;
  int i_29;
  int j_30;
  i_11 = i_27;
  j_12 = j_26;
  loop_28:
  flag_set(i_11, atsbool_true);
  turn_set(i_11);
  ((flag_get(j_12)) == (atsbool_false)) + ((j_12) == (turn_get()));
  printf("pid: %d \n", i_11);
  vlock_acquire();
  vlock_release();
  flag_set(i_11, atsbool_false);
  i_29 = i_11;
  j_30 = j_12;
  i_11 = i_29;
  j_12 = j_30;
  goto loop_28
}
proctype proc_0() {
  int i_1;
  int j_7;
  i_1 = get_pid();
  assert(((i_1) == (int2pid(0))) + ((i_1) == (int2pid(1))));
  j_7 = int2pid((1) - (pid2int(i_1)));
  loop_10(i_1, j_7)
}
init {
atomic {
  int pid1_23;
  int pid2_25;
  pid1_23 = run proc_0();
  pid2_25 = run proc_0()
}
}

