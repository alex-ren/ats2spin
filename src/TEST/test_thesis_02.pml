
proctype foo (int n) {
  int x = 0;
  int y = 0;

  incx:
  if
  :: x > n ->
    goto end
  :: else -> 
      x = x + 1;
      goto incy
  fi

  incy:
  y = y + 1;
  goto incx

  end:

  printf("x is %d\n", x)
  printf("y is %d\n", y)
}

init {
atomic {
  run foo(100)
}
}

