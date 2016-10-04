
staload "./Promela.sats"

#define DATA_FRAME_LENGTH 8

// sortdef sid = int
// 
// stacst sg_reglen: sid  // id for the variable holding g_dRegLength
// 
// absview gvis (sid, int)
// 
// extern fun gvar_get

#define CAP 20
#define FRAME 8

absview dregister_v (int (*len*), int (*cap*))
// viewdef dregister_v (rd: int, len: int) = 
//   [rd <= len; len <= CAP] (dregister_v (rd, len, CAP))

extern fun dregister_get 
  {rd, len: nat | rd < (len / FRAME) * FRAME; len <= CAP}
  ( vpf: dregister_v (len, CAP)
  | n: int rd
  ): byte

extern fun dregister_swap 
  {rd, len: nat | rd == (len / FRAME) * FRAME; len <= CAP}
  ( vpf: dregister_v (len, CAP)
  | n: int rd
  ): (dregister_v (len - rd, CAP) | void)

extern fun dregister_get_len
  {len: nat | len <= CAP} (
  vpf: dregister_v (len, CAP)
  | ): int len



////

absview g_array (

extern fun g_dRegister_update (

fun inline$ReceiveData (): void = let

  var dRegRead = 0

in
  
