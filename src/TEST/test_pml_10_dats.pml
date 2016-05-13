inline fact_0(x_9, res_8) {
  int x_1;
  int res_2;
  int x_11;
  int res_12;
  x_1 = x_9;
  res_2 = res_8;
  fact_10:
  if 
  :: (x_1) > (0) -> 
    x_11 = (x_1) - (1);
    res_12 = (x_1) * (res_2);
    x_1 = x_11;
    res_2 = res_12;
    goto fact_10
  :: else  -> 
    printf("ans = %d", res_2)
  fi
}
init {
  int x_7;
  x_7 = 5;
  fact_0(x_7, 1)
}

