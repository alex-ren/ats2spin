
(*
*  gt
*
* )

datatype type0 =
| TYPE0_int
| TYPE0_fun of (type0lst, type0)

where
type0lst = list0 type0

abstype i0var = ptr

datatype i0ins =
| INS0assign of (i0var, i0exp)
| INS0label of (i0var)

and i0exp =
| EXP0int of (int)
| EXP0app of (i0var, i0explst)

where
i0explst = list0 i0exp





