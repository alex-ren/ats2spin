
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./instr0.sats"

assume i0fundef = '{
  i0fundef_name = i0id
  , i0fundef_paralst = i0idlst
  , i0fundef_inss = i0inslst
  , i0fundef_group = i0idlst
}

implement i0fundef_create (
  name
  , paralst
  , inss
  , group
  ) = '{
  i0fundef_name = name
  , i0fundef_paralst = paralst
  , i0fundef_inss = inss
  , i0fundef_group = group
  }

