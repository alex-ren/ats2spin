
// The example is used to confirm the fact that `statement`
// doesn't cause extra state.
// This is shown by the fact that the program consisting of
// `foo0` and `foo2` has the same amount of states as the one
// consisting of `foo1` and `foo2`.

int g = 0;

// active proctype foo0 () {
//   g = g + 1;
//   g = g + 1;
// 
//   g = g + 1;
//   g = g + 1;
// }

active proctype foo1 () {
  g = g + 1;
  g = g + 1;
  goto xxx;
  g = g + 1;

xxx:
  g = g + 1;
  g = g + 1;
}

active proctype foo2 () {
  g = g + 100;
  g = g + 10000;
}



