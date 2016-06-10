/*
* This file is for testing the inclusion of Promela
* code in ATS.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

%{
int g = 3;
int g2 = 4;
%}

fun pml$init (): void = let
  val () = pml$assert (3 > 2)
in 
end




