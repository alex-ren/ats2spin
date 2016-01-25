
sortdef int2 = {n: nat | n < 2}

absview own_slot_v (int, int)

extern prfun mc_acquire_ownership {x,y:int2} (
  x: int x, y: int y): (own_slot_v (x, y) | void)

extern prfun mc_release_ownership {x,y:int2} (
  v: own_slot_v (x, y) | x: int x, y: int y): void

fun write (): void = let
  val pair = 1 - reading_get ()
  val index = 1 - slot_get (pair)

  prval vpf = mc_acquire_ownership (pair, index)
  prval () = mc_release_ownership (vpf | pair, index)

  val () = slot_update (pair, index)
  val () = latest_update (pair)
in end

fun read (): void = let
  val pair = latest_get ()
  val () = reading_update (pair)
  val index = slot_get (pair)

  prval vpf = mc_acquire_ownership (pair, index)
  prval () = mc_release_ownership (vpf | pair, index)
in end

