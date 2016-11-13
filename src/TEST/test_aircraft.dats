


absview arraybufview (len: int, beg:int, tail: int)

// extern fun arraybufview_create {len: nat} (
//   len: int len, x: int): 
//   (arraybufview (len, 0, 0) | void)

extern fun arraybufview_get 
  {len, beg, tail, n: nat | beg <= n; n < tail; tail <= len} (
  pf: !arraybufview (len, beg, tail) >> arraybufview (len, beg + 1, tail)
  | pos: int n): int

extern fun arraybufview_set
  {len, beg, tail: nat | beg <= tail; tail < len} (
  pf: !arraybufview (len, beg, tail) >> arraybufview (len, beg, tail + 1) 
  | pos: int tail, x: int): void

extern prfun arraybufview_rewind
  {len, beg, tail: nat | beg == tail; tail <= len} (
  pf: !arraybufview (len, beg, tail) >> arraybufview (len, 0, 0)): void

fun foo (pf: !arraybufview (3, 0, 1)): void = let
  val x0 = arraybufview_get (pf | 0)
  // pf: arraybufview (3, 1, 1)

  val () = arraybufview_set (pf | 1, 100)
  // pf: arraybufview (3, 1, 2)

  val () = arraybufview_set (pf | 2, 100)
  // pf: arraybufview (3, 1, 3)

  val x1 = arraybufview_get (pf | 1)
  // pf: arraybufview (3, 2, 3)

  val x2 = arraybufview_get (pf | 2)
  // pf: arraybufview (3, 3, 3)

  prval () = arraybufview_rewind (pf)
  // pf: arraybufview (3, 0, 0)

  val () = arraybufview_set (pf | 0, 100)
  // pf: arraybufview (3, 0, 1)

in () end


#define DATA_FRAME_LENGTH 8
#define MAX_REG_LENGTH 20

stacst g_read: int
stacst g_len: int

absview gv (int, int)

extern fun g_read_set {x0, x: int} (!gv (g_read, x0) >> gv (g_read, x) | int x): void
extern fun g_read_get {x0: int} (!gv (g_read, x0)): int x0

extern fun g_len_set {x0, x: int} (!gv (g_len, x0) >> gv (g_len, x) | int x): void
extern fun g_len_get {x0: int} (!gv (g_len, x0)): int x0

fun inline$ReceiveData {beg1, tail1: nat} {arrlen: nat | tail1 <= arrlen} (
  pf_read: !gv (g_read, beg1) >> gv (g_read, beg2)
, pf_len: !gv (g_len, tail1) >> gv (g_len, tail2)
, pf_buf: !arraybufview (arrlen, 0, tail1) >> arraybufview (arrlen, 0, tail2)
| void): #[beg2, tail2: nat | tail2 < DATA_FRAME_LENGTH] void = let
  val tail = g_len_get (pf_len)
in
  if tail < DATA_FRAME_LENGTH then ()
  else let
    fun loop {beg1, tail1: nat | tail1 - beg1 >= DATA_FRAME_LENGTH; tail1 <= arrlen} (
      pf_read: !gv (g_read, beg1) >> gv (g_read, beg2)
    , pf_len: !gv (g_len, tail1) >> gv (g_len, tail2)
    , pf_buf: !arraybufview (arrlen, beg1, tail1) >> arraybufview (arrlen, 0, tail2)
    | void): #[beg2, tail2: nat | tail2 < DATA_FRAME_LENGTH] void = let

    extern fun process_frame 
    {beg, tail: nat | tail - beg >= DATA_FRAME_LENGTH; tail <= arrlen} (
    pf_buf: !arraybufview (arrlen, beg, tail) >> arraybufview (arrlen, beg + 8, tail)
    | beg: int beg): bool

    extern fun move_data {beg,tail: nat | beg <= tail; tail < beg + 8} (
    pf_buf: !arraybufview (arrlen, beg, tail) >> arraybufview (arrlen, 0, tail - beg)
    | beg: int beg, tail: int tail): void
    
    in
      if process_frame (pf_buf | g_read_get (pf_read)) then let
        val () = g_read_set (pf_read | g_read_get (pf_read) + 8)
        val tail = g_len_get (pf_len)
        val tail1 = tail - g_read_get (pf_read)
      in
        if tail1 >= DATA_FRAME_LENGTH then loop (pf_read, pf_len, pf_buf | ())
        else let 
          val () = move_data (pf_buf | g_read_get (pf_read), tail)
          val () = g_len_set (pf_len | tail1)
        in
        end
      end
      else let
        val () = g_read_set (pf_read | g_read_get (pf_read) + 8)
        // val () = g_read_set (pf_read | g_read_get (pf_read) + 8)
        val tail = g_len_get (pf_len)
        val tail1 = tail - g_read_get (pf_read)
      in
        if tail1 >= DATA_FRAME_LENGTH then loop (pf_read, pf_len, pf_buf | ())
        else let 
          val () = move_data (pf_buf | g_read_get (pf_read), tail)
          val () = g_len_set (pf_len | tail1)
        in
        end
      end
    end
    val () = g_read_set (pf_read | 0)
  in
    loop (pf_read, pf_len, pf_buf | ())
  end
end
  

////
  val (pf | ()) = arraybufview_set (pf | 
////
extern fun arrayview_destroy 
  {a:t@ype} {len: nat} {l:addr | l >= null} (
  pf: arraybufview (a, len, l) | p: ptr l): void


extern fun arrayview_get2
  {a:t@ype} {n, len: nat | n < len} {l:addr | l >= null} (
  pf: !arraybufview (a, len, l) | p: ptr l, pos: int n): a
