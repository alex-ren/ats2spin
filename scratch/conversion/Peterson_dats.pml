
bit turn = 0;
bool flag[2] = false;

#define get_other_party(ats_pid) (1 - ats_pid)

#define flag_get(ats_pid) flag[ats_pid]

inline flag_set(ats_pid, i) {
  flag[ats_pid] = i;
}

#define turn_get() turn

inline turn_set(ats_pid) {
  turn = 1 - ats_pid;
}


// ============================
// Generated

inline user_loop (clo_arg_i, clo_arg_pid) {
  skip;
user_loop_beg:
  flag_set(clo_arg_pid, true);
  turn_set(clo_arg_pid);
  flag_get(get_other_party(clo_arg_pid)) == false ||
    clo_arg_pid == turn_get();
  //
  // This is a critial section
  //
  flag_set(clo_arg_pid, false);
  goto user_loop_beg;
}

active proctype user() {
  int ats_pid = _pid;  // Promela$mypid() => _pid
  int i = ats_pid;
  assert((i == 0) + (i == 1));

  user_loop(i, ats_pid);
}






