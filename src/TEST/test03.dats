
staload "./Promela.sats"

val gx:gid_t = promela_gvar_create<int> (3)
val gy:gid_t = promela_gvar_create<int> (promela_gvar_get<int> (gx) + 1)

