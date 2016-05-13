
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

staload "./../postiats/utfpl.sats"
staload "./instr0.sats"

#define :: list0_cons
#define nil list0_nil

(* ************ ************* *)

fun i0optimize_i0prog_on_i0fundef (i0prog: i0prog, fopr: i0fundef -<cloref1> i0fundef): i0prog = let
  val i0funmap = i0prog.i0prog_i0funmap

  // create a new map to hold newly generated functions
  val fmap = i0funmap_create (i2sz(2048))
  // 
  val i0declst = loop (i0prog.i0prog_i0declst, fmap) where {
  fun loop (i0declst: i0declst
            , fmap: i0funmap
           ): i0declst = 
    case+ i0declst of
    | list0_cons (i0dec, i0declst1) => 
      (
      case+ i0dec of
      | DEC0fun (fundef) => let
        val fundef' = fopr (fundef)  // i0optimize_tailcall_fundef (sa, fundef, i0funmap)
        val () = i0funmap_insert_any (fmap, i0fundef_get_id (fundef), fundef')
        val i0declst = loop (i0declst1, fmap)
      in
        DEC0fun (fundef') :: i0declst
      end
      | _ => let
        val i0declst1' = loop (i0declst1, fmap)
      in
        i0dec :: i0declst1'
      end
      )
    | list0_nil () => nil0
  }
  
  val i0prog1 = '{
    i0prog_i0funmap = fmap
    , i0prog_i0declst = i0declst 
  }
in
  i0prog1
end  // end of [i0optimize_tailcall]

implement i0optimize_tailcall (sa, i0prog) = let
  val i0funmap = i0prog.i0prog_i0funmap
  fun fopr (i0fundef: i0fundef):<cloref1> i0fundef = i0optimize_tailcall_fundef (sa, i0fundef, i0funmap)
in
  i0optimize_i0prog_on_i0fundef (i0prog, fopr)
end

(* *********** ************ *)

implement i0optimize_tailcall_fundef (sa, i0fundef, i0funmap) =
if ~i0fundef_is_recursive (i0fundef) then i0fundef
else let
  val fnames = i0fundef_get_group (i0fundef)
  val fname = i0fundef_get_id (i0fundef)

  // grab all the parameters from all the functions
  val group_paralst = list0_foldleft<i0id><list0(i0id)> (
                fnames, list0_nil (), fopr) where {
  fun fopr (res: i0idlst, i0id: i0id):<cloref1> i0idlst = let
    val i0fundef = i0funmap_search0 (i0funmap, i0id)
    val paralst = i0fundef_get_paralst (i0fundef)
  in
    list0_append (res, paralst)
  end
  }

  // create new parameters for the current function
  typedef para_old_new = @(i0id (*variable*), i0id (*parameter*))
  val cur_paralst = i0fundef_get_paralst (i0fundef)
  val para_pair_lst = list0_foldright<i0id><list0 para_old_new> (
                    cur_paralst, fopr, nil) where {
    fun fopr (i0id:i0id, res: list0 para_old_new):<cloref1> list0 para_old_new = let
      val new_i0id = i0id_copy (i0id, sa)
      val res = list0_cons (@(i0id, new_i0id), res)
    in
      res
    end
  }

  val new_paralst = list0_foldright<para_old_new><i0idlst> (
                     para_pair_lst, lam (p, res) => p.1 :: res, nil)   

  // build an extra instruction for initialization
  val ins_init = INS0init_loop (group_paralst, para_pair_lst)

  // build tags for all the functions in the group
  // map function name to tag
  val map_fname_tag = i0idmap_create (i2sz(1024))
  val () = list0_foreach (fnames, fopr) where {
  fun fopr (i0id: i0id):<cloref1> void = let
    val new_id = i0id_copy_remove_prefix_inline (i0id, sa)
    val () = i0idmap_insert_any (map_fname_tag, i0id, new_id)
  in end
  }

  // transform current function
  val cur_inss = i0fundef_get_instructions (i0fundef)
  
  (* ****************** ************** *)
  fun optimize_tailcall_return2jump (
    inss: i0inslst
    , map_fname_tag: i0idmap
    , i0funmap: i0funmap
  ): i0inslst = let

    fun loop (inss: i0inslst
              , accu: i0inslst): i0inslst =
    case+ inss of
    | list0_cons (ins, inss1) => let
      val ins' = transform_return2jump (ins)
      val accu' = list0_cons (ins', accu)
    in
      loop (inss1, accu')
    end
    | list0_nil () => list0_reverse (accu)
    // end of [loop]
    and
    transform_return2jump (
      ins: i0ins
    ): i0ins = case+ ins of
    | INS0decl (_, _) => ins
    | INS0assign (_, _) => ins
    | INS0label (_) => ins
    | INS0return (i0expopt) => 
      (case+ i0expopt of
      | Some0 i0exp => (case+ i0exp of
        | EXP0int _ => ins
        | EXP0i0nt _ => ins
        | EXP0string _ => ins
        | EXP0var _ => ins
        | EXP0extfcall _ => ins
        | EXP0lambody _ => exitlocmsg ("This should not happen.")
        | EXP0app (i0id, i0explst) => let
          val tag_id_opt = i0idmap_search (map_fname_tag, i0id)
        in
          case+ tag_id_opt of
          | ~Some_vt (tag_id) => let
            val i0fundef = i0funmap_search0 (i0funmap, i0id)
            val paralst = i0fundef_get_paralst (i0fundef)

            val para_pair_lst = list0_foldleft<i0id><list0 para_old_new> (
                              paralst, list0_nil, fopr) where {
              val () = $tempenver(sa)  // Handling a bug for ATS.
              fun fopr (res: list0 para_old_new
                  , i0id: i0id):<cloref1> list0 para_old_new = let
                val new_i0id = i0id_copy (i0id, sa)
                val res = list0_cons (@(i0id, new_i0id), res)
              in
                res
              end
            }
            val para_pair_lst = list0_reverse (para_pair_lst)

            val (calc_exp_lst, assign_lst) = loop (i0explst, para_pair_lst) where {
            fun loop (
              i0explst: i0explst
              , para_pair_lst: list0 para_old_new)
            : (i0inslst(*calc exp*), i0inslst (*assign var*)) = 
            case+ (i0explst, para_pair_lst) of
            | ((i0exp :: i0explst1), (para_pair :: para_pair_lst1)) => let
              val (inss1, inss2) = loop (i0explst1, para_pair_lst1)
              val ins1 = INS0decl (para_pair.1, Some0 i0exp)
              val ins2 = INS0assign (Some0 (para_pair.0), EXP0var (para_pair.1))
              val inss1 = ins1 :: inss1
              val inss2 = ins2 :: inss2
            in (inss1, inss2) end
            | (nil (), nil ()) => (nil (), nil ())
            | (_, _) => exitlocmsg ("This shall not happen")
            }
            
            val ins = INS0tail_jump (list0_append (calc_exp_lst, assign_lst), tag_id)
          in
            ins
          end
          | ~None_vt () => ins
        end
        )
      | None0 () => ins
      )
    | INS0ifbranch (i0exp, i0inslst1 (*if*), i0inslst2 (*else*)) => let
      val i0inss3 = optimize_tailcall_return2jump (i0inslst1, map_fname_tag, i0funmap)
      val i0inss4 = optimize_tailcall_return2jump (i0inslst2, map_fname_tag, i0funmap)
    in
      INS0ifbranch (i0exp, i0inss3, i0inss4)
    end
    | INS0goto (_) => ins
    | INS0init_loop (_, _) => exitlocmsg ("Impossible.")
    | INS0tail_jump (_, _) => exitlocmsg ("Impossible.")
    // end of [transform_return2jump]

    val ret = loop (inss, list0_nil ())
  in
    ret
  end  // end of [optimize_tailcall_return2jump]

  (* ****************** ************** *)

  // We process the current function first.

  // build an extra instruction for the beginning label
  val- ~Some_vt(cur_tag) = i0idmap_search (map_fname_tag, fname)
  val ins_label = INS0label (cur_tag)

  val cur_inss = optimize_tailcall_return2jump (
    cur_inss, map_fname_tag, i0funmap)
  // val cur_inss = ins_init :: ins_label :: new_inss

  val group_inss = list0_foldright<i0id><i0inslst> (
    fnames, fopr, nil) where {
  fun fopr (cur_name: i0id, res_inss: i0inslst):<cloref1> i0inslst = 
    // Skip since the current one has been processed previously.
    if cur_name = fname then res_inss  
    else let
    val i0fundef = i0funmap_search0 (i0funmap, cur_name)
    val cur_inss = i0fundef_get_instructions (i0fundef)
    val cur_inss = optimize_tailcall_return2jump (
      cur_inss, map_fname_tag, i0funmap)

    val- ~Some_vt(tag) = i0idmap_search (map_fname_tag, cur_name)
    val ins_label = INS0label (tag)
    val res_inss = list0_append (ins_label :: cur_inss, res_inss)
  in
    res_inss
  end
  }
  val new_inss = list0_append (ins_init :: ins_label :: cur_inss, group_inss)

  val new_fundef = i0fundef_create (
    fname
    , new_paralst
    , new_inss
    , fnames
    )
in
  new_fundef
end  // end of [i0optimize_tailcall_fundef]

implement i0optimize_collect_decs (i0prog) = let
  fun fopr (i0fundef: i0fundef):<cloref1> i0fundef = 
    i0optimize_collect_decs_fundef (i0fundef)
in
  i0optimize_i0prog_on_i0fundef (i0prog, fopr)
end

implement i0optimize_collect_decs_fundef (i0fundef) = let

  fun loop (i0inslst: i0inslst
            , res1: i0inslst (* ins list for INS0decl *)
            , res2: i0inslst (* new instruction list *)
           ): (i0inslst (*res1'*), i0inslst(*res2'*)) =
  case+ i0inslst of
  | i0ins :: i0inslst1 =>
    (
    case+ i0ins of
    | INS0decl (i0id, i0expopt) =>
      (
      case+ i0expopt of
      | Some0 i0exp => let
        val ins_dec = INS0decl (i0id, None0)
        val ins_assign = INS0assign (Some0 i0id,  i0exp)
        val res1' = ins_dec :: res1
        val res2' = ins_assign :: res2
      in
        loop (i0inslst1, res1', res2')
      end
      | None0 () => let  // move pure declaration to the beginning
        val res1' = i0ins :: res1
      in
        loop (i0inslst1, res1', res2)
      end
      )
    | INS0assign (i0idopt, i0exp) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0label (i0id) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0return (i0expopt) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0ifbranch (i0exp, i0inslst_if (*if*), i0inslst_else (*else*)) => let
      val (res1', inss_in_if) = loop (i0inslst_if, res1, nil0)
      val (res1'', inss_in_else) = loop (i0inslst_else, res1', nil0)
      val ins = INS0ifbranch (i0exp, inss_in_if, inss_in_else)
      val res2' = ins :: res2
    in
      loop (i0inslst1, res1'', res2')
    end
    | INS0goto (i0id) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0init_loop (
      i0idlst (*all variables*)
      , tuplst (*list0 (@(i0id, i0id))*) 
               (*variabe and initial value from para*)) => let
      val dec_inss = list0_foldleft (i0idlst, res1, fopr) where {
      fun fopr (res: i0inslst, i0id: i0id):<cloref1> i0inslst = let
        val ins = INS0decl (i0id, None0)
      in
        ins :: res
      end
      }

      val assign_inss = list0_foldleft (tuplst, res2, fopr) where {
      fun fopr (res: i0inslst, tup: @(i0id, i0id)):<cloref1> i0inslst = let
        val ins = INS0assign (Some0 tup.0, EXP0var (tup.1))
      in
        ins :: res
      end
      }
    in
      loop (i0inslst1, dec_inss, assign_inss)
    end
    | INS0tail_jump (inss (*calc arg*), i0id (*jump tag*)) => let
      val (res1', ninss) = loop (inss, res1, nil0)
      val ni0ins = INS0tail_jump (ninss, i0id)
    in
      loop (i0inslst1, res1', ni0ins :: res2)
    end
    )
  | nil0 () => (res1, list0_reverse res2)  // end of [loop]

  (* ******** ******** *)

  val id = i0fundef_get_id (i0fundef)
  val paralst = i0fundef_get_paralst (i0fundef)

  val inss = i0fundef_get_instructions (i0fundef)
  val (inss1, inss2) = loop (inss, nil0, nil0)
  val inss_new = list0_reverse_append (inss1, inss2)

  val group = i0fundef_get_group (i0fundef)

  val new_fundef = i0fundef_create (
    id
    , paralst
    , inss_new
    , group
    )
in
  new_fundef
end  // end of [i0optimize_collect_decs_fundef]

  
  
  

