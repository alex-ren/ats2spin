

int g = 1;

proctype foo(bool b) {
  if
  :: b -> g = 2;
  :: else -> g = 3;
  fi
  printf("end of foo\n");

}


init {

  run foo(true);
  printf("end of init\n");
}


  
