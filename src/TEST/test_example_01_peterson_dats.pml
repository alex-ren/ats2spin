
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



inline loop_7(i_24, j_23) {
  pid i_8;
  pid j_9;
  pid i_26;
  pid j_27;
  i_8 = i_24;
  j_9 = j_23;
  loop_25:
  flag_set(i_8, atsbool_true);
  turn_set(i_8);
  ((flag_get(j_9)) == (atsbool_false)) + ((j_9) == (turn_get()));
  printf("pid: %d \n", i_8);
  vlock_acquire();
  vlock_release();
  flag_set(i_8, atsbool_false);
  i_26 = i_8;
  j_27 = j_9;
  i_8 = i_26;
  j_9 = j_27;
  goto loop_25
}
proctype proc_0() {
  pid i_1;
  pid j_5;
  i_1 = get_pid();
  assert(((i_1) == (int2pid(0))) + ((i_1) == (int2pid(1))));
  j_5 = int2pid((1) - (pid2int(i_1)));
  loop_7(i_1, j_5)
}
init {
atomic {
  pid pid1_20;
  pid pid2_22;
  pid1_20 = run proc_0();
  pid2_22 = run proc_0()
}
}

