
staload "./Promela.sats"

%{

int g = 1;
#define get_g() g
inline get_g2(x) {
  x = g
}

inline set_g(x) {
  g = x
}

%}

extern fun get_g (): int
extern fun get_g2 (x: &int): void
extern fun set_g (x: int): void

fun proctype$foo (): void = let
  val lg1 = get_g ()
  val () = $extfcall (void, "printf", "g is %d\\n", lg1)
  var lg2: int = 0
  val () = get_g2 (lg2)
  val () = pml$assert0 (lg1 = lg2)
  val () = set_g (lg1 + lg2)
in end

fun pml$init (): void = let
  val _ = pml$run (proctype$foo ())
in end


