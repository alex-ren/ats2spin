
staload "./Promela.sats"

absviewtype ref_int (x: int) = ptr
extern fun ref_int_make {x:int} (x: int x): ref_int (x)
extern fun ref_int_update {x,y:int} (r: !ref_int x >> ref_int y, y: int y): void
extern fun ref_int_get {x:int} (r: ref_int x): int x
extern fun ref_int_release {x:int} (r: ref_int x): void

fun foo (): void = let
  val x = ref_int_make (3)
  val () = ref_int_update (x, 1)
  extern fun assert (r: !ref_int (1)): void
  
  val () = assert (x)
  val () = ref_int_release (x)
in
end

fun plus (x: int, y: int): int = x + y

fun loop (x: int, accu: int): int =
  if x <= 0 then accu
  else let
    val p = plus (accu, x)
  in
    loop (x - 1, p)
  end

fun proctype_p (): void = let
  val r1 = loop (1, 1)
  val r2 = loop (r1, 1)
  val x = r1 + r2
in
end

(* ******* ******** *)

plus (x, y; ret)  // no recursive
ret = x + y;

loop (x, accu; ret)  // is recursive
var x0 = x;  // x0 is unique
var accu0 = accu;

label fact_begin:
    if (x0 == 0) {
        ret = accu0;
        goto fact_end;
    } else {
        d_step {
        var p;
        plus (x, y; p);
        var x0' = x0 - 1;
        var accu0' = p;
        x0 = x0'
        accu0 = accu';
        goto fact_begin;
        }
    }
label fact_end:

proctype_p ()
  var r1;
  loop (1, 1; r1)
  var r2;
  loop (r1, 1; r2)
  var x = r1 + r2;
  
(* ******* ******** *)

// assume x >= 0
fun is_even (x: int): bool =
  if x = 0 then true
  else is_odd (x - 1)
and
is_odd (y: int): bool =
  if y = 0 then false
  else is_even (y - 1)

(* ******* ******** *)

is_even_is_odd (choice, x, y; ret)
d_step {
  var x0 = x;
  var y0 = y;
}

label is_even:
    if (x0 = 0) {
        ret = true;
        goto is_even_is_odd_end;
    } else {
        x0' = x0 - 1;
        x0 = x0';
        goto label_is_odd;
    }

label is_odd:
    if (x0 == 0) {
        ret = false;
        goto is_even_is_odd_end;
    } else {
        x0' = x0' - 1;
        x0 = x0';
        goto label_is_even;
    }

label is_even_is_odd_end:



do
:: x > 0 -> accu = accu + 1;














