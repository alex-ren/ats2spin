

sortdef gname = int

abstype lock_t (gname)
typedef lock(g: gname) = lock_t(g)

absview lockview (g:gname)

fun lock_create {g:gname} (): lock (g)
fun lock_acquire {g:gname} (l: lock (g)): (lockview (g) | void)
fun lock_release {g:gname} (v: lockview (g)): void
fun lock_islocked {g:gname} (l: lock (g)): bool



