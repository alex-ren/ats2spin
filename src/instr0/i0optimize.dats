
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./instr0.sats"

#define :: list0_cons
#define nil list0_nil

(* ************ ************* *)

// This function is used for both i0optimize_tailcall and
// i0optimize_collect_decs.
fun i0optimize_i0prog_on_i0fundef (
  i0prog: i0prog
  , fopr: i0fundef -<cloref1> i0fundef
  ): i0prog = let
  // val i0funmap = i0prog.i0prog_i0funmap

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
end  // end of [i0optimize_i0prog_on_i0fundef]

implement i0optimize_tailcall (sa, i0prog) = let
  val i0funmap = i0prog.i0prog_i0funmap
  fun fopr (i0fundef: i0fundef):<cloref1> i0fundef = 
    i0optimize_tailcall_fundef (sa, i0fundef, i0funmap)
in
  i0optimize_i0prog_on_i0fundef (i0prog, fopr)
end

(* ************************* ************************** *)

// Turn recursive call into jump
fun optimize_tailcall_recursivecall2jump (
  inss: i0inslst
  // mapping function name to corresponding tag (for jump)
  , map_fname_tag: i0idmap  
  , i0funmap: i0funmap
  , ref_para_map: i0idmap
  , sa: stamp_allocator
): i0inslst = let

  fun loop (inss: i0inslst
            , accu: i0inslst): i0inslst =
  case+ inss of
  | list0_cons (ins, inss1) => let
    // val () = fprint (stderr_ref, "========================== start\n")
    val ins' = transform_return2jump (ins)
    // val () = fprint (stderr_ref, "========================== end\n")
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
  | INS0assign (i0expopt, i0exp) =>
    (case+ i0exp of
    | EXP0int _ => ins
    | EXP0i0nt _ => ins
    | EXP0string _ => ins
    | EXP0var _ => ins
    | EXP0any () => exitlocmsg ("This should not happen.")
    | EXP0extfcall _ => ins
    | EXP0lambody _ => exitlocmsg ("This should not happen.")
    | EXP0matchtag (_, _) => ins
    | EXP0app (fnameid, i0explst) => 
    if i0id_is_any (fnameid) || i0id_is_sym (fnameid) 
    then ins  // These two have no stamps.
    else let
      // val () = fprint (stderr_ref, "========================== 90\n")
      val tag_id_opt = i0idmap_search (map_fname_tag, fnameid)
    in
      case+ tag_id_opt of
      | ~Some_vt (tag_id) => let  // jump to tag_id
        // val () = fprint (stderr_ref, "========================== 100\n")
        val i0fundef = i0funmap_search0 (i0funmap, fnameid)
        val paralst = i0fundef_get_paralst (i0fundef)

        val (calc_exp_lst, assign_lst) = loop (i0explst, paralst) where {
        fun loop (
          i0explst: i0explst
          , paralst: i0idlst)
        : (i0inslst(*calc exp*), i0inslst (*assign var*)) = 
        case+ (i0explst, paralst) of
        | ((i0exp :: i0explst1), (para :: paralst1)) => let
          val type0 = i0id_get_type (para)
        in
          if type0_is_ref (type0) then let
            val- EXP0var (arg) = i0exp

            // find the mapped name for the parameter
            val mapped_para_vt = i0idmap_search (ref_para_map, para)
            val mapped_para = (case+ mapped_para_vt of
                              | ~Some_vt (para') => para'
                              | ~None_vt () => para
                              ): i0id

            // find the mapped name for the argument
            val mapped_arg_vt = i0idmap_search (ref_para_map, arg)
            val mapped_arg = (case+ mapped_arg_vt of
                              | ~Some_vt (arg') => arg'
                              | ~None_vt () => arg
                              ): i0id
          in
            // no need to do anything for parameters of reference types
            if (mapped_arg = mapped_para) then loop (i0explst1, paralst1)
            else exitlocmsg ("parameter of reference type misused\n")
          end
          else let
            val (inss1, inss2) = loop (i0explst1, paralst1)
            // create new temporary variables for computation result
            val new_i0id = i0id_copy (para, sa) 
            val ins1 = INS0decl (new_i0id, Some0 i0exp)
            val ins2 = INS0assign (Some0 (EXP0var para), EXP0var (new_i0id))
            val inss1 = ins1 :: inss1
            val inss2 = ins2 :: inss2
          in (inss1, inss2) end
        end
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
  // end of [INS0assign]

  | INS0label (_) => ins
  // | INS0return (i0expopt) => 
  //   (case+ i0expopt of
  //   | Some0 i0exp => (case+ i0exp of
  //     | EXP0int _ => ins
  //     | EXP0i0nt _ => ins
  //     | EXP0string _ => ins
  //     | EXP0var _ => ins
  //     | EXP0any () => exitlocmsg ("This should not happen.")
  //     | EXP0extfcall _ => ins
  //     | EXP0lambody _ => exitlocmsg ("This should not happen.")
  //     | EXP0matchtag (_, _) => ins
  //     | EXP0app (fnameid, i0explst) => let
  //       val tag_id_opt = i0idmap_search (map_fname_tag, fnameid)
  //     in
  //       case+ tag_id_opt of
  //       | ~Some_vt (tag_id) => let  // jump to tag_id
  //         val i0fundef = i0funmap_search0 (i0funmap, fnameid)
  //         val paralst = i0fundef_get_paralst (i0fundef)

  //         val (calc_exp_lst, assign_lst) = loop (i0explst, paralst) where {
  //         fun loop (
  //           i0explst: i0explst
  //           , paralst: i0idlst)
  //         : (i0inslst(*calc exp*), i0inslst (*assign var*)) = 
  //         case+ (i0explst, paralst) of
  //         | ((i0exp :: i0explst1), (para :: paralst1)) => let
  //           val type0 = i0id_get_type (para)
  //         in
  //           if type0_is_ref (type0) then let
  //             val- EXP0var (arg) = i0exp

  //             // find the mapped name for the parameter
  //             val mapped_para_vt = i0idmap_search (ref_para_map, para)
  //             val mapped_para = (case+ mapped_para_vt of
  //                               | ~Some_vt (para') => para'
  //                               | ~None_vt () => para
  //                               ): i0id

  //             // find the mapped name for the argument
  //             val mapped_arg_vt = i0idmap_search (ref_para_map, arg)
  //             val mapped_arg = (case+ mapped_arg_vt of
  //                               | ~Some_vt (arg') => arg'
  //                               | ~None_vt () => arg
  //                               ): i0id
  //           in
  //             // no need to do anything for parameters of reference types
  //             if (mapped_arg = mapped_para) then loop (i0explst1, paralst1)
  //             else exitlocmsg ("parameter of reference type misused\n")
  //           end
  //           else let
  //             val (inss1, inss2) = loop (i0explst1, paralst1)
  //             // create new temporary variables for computation result
  //             val new_i0id = i0id_copy (para, sa) 
  //             val ins1 = INS0decl (new_i0id, Some0 i0exp)
  //             val ins2 = INS0assign (Some0 (EXP0var para), EXP0var (new_i0id))
  //             val inss1 = ins1 :: inss1
  //             val inss2 = ins2 :: inss2
  //           in (inss1, inss2) end
  //         end
  //           | (nil (), nil ()) => (nil (), nil ())
  //           | (_, _) => exitlocmsg ("This shall not happen")
  //         }
  //         
  //         val ins = INS0tail_jump (list0_append (calc_exp_lst, assign_lst), tag_id)
  //       in
  //         ins
  //       end
  //       | ~None_vt () => ins
  //     end
  //     )
  //   | None0 () => ins
  //   )
  | INS0ifbranch (i0exp, i0inslst1 (*if*), i0inslst2 (*else*)) => let
    val i0inss3 = optimize_tailcall_recursivecall2jump (
      i0inslst1, map_fname_tag, i0funmap, ref_para_map, sa)
    val i0inss4 = optimize_tailcall_recursivecall2jump (
      i0inslst2, map_fname_tag, i0funmap, ref_para_map, sa)
  in
    INS0ifbranch (i0exp, i0inss3, i0inss4)
  end
  | INS0random (i0gbranchlst, inssopt) => let
    val i0gbranchlst' = 
      list0_foldright<i0gbranch><i0gbranchlst> (
        i0gbranchlst, fopr, nil0) where {
    fun fopr (i0gbranch: i0gbranch, res: i0gbranchlst):<cloref1> i0gbranchlst = let
      val i0inss = optimize_tailcall_recursivecall2jump (
                  i0gbranch.i0gbranch_inss, map_fname_tag, i0funmap, ref_para_map, sa)
      val i0gbranch' = i0gbranch_make (i0gbranch.i0gbranch_guard, i0inss)
    in
      cons0 (i0gbranch', res)
    end
    }
  in
    case+ inssopt of
    | Some0 inss => let
      val inss_in_else = optimize_tailcall_recursivecall2jump (
         inss, map_fname_tag, i0funmap, ref_para_map, sa)
      val ins = INS0random (i0gbranchlst', Some0 inss_in_else)
    in
      ins
    end
    | None0 () => let
      val ins = INS0random (i0gbranchlst', None0 ())
    in
      ins
    end
  end  // end of [INS0randome]
  | INS0goto (_) => ins
  | INS0exception () => ins
  | INS0init_loop (_, _) => exitlocmsg ("Impossible.")
  | INS0tail_jump (_, _) => exitlocmsg ("Impossible.")
  // end of [transform_return2jump]

  val ret = loop (inss, list0_nil ())
in
  ret
end  // end of [optimize_tailcall_recursivecall2jump]

(* ************************* ************************** *)

implement i0optimize_tailcall_fundef (sa, i0fundef, i0funmap) =
if ~i0fundef_is_recursive (i0fundef) then i0fundef
else let
  val fnames = i0fundef_get_group (i0fundef)
  val fname = i0fundef_get_id (i0fundef)

  // grab all the parameters from all the functions
  val nonref_group_paralst = list0_foldleft<i0id><list0(i0id)> (
                fnames, list0_nil (), fopr) where {
  fun fopr (res: i0idlst, i0id: i0id):<cloref1> i0idlst = let
    val i0fundef = i0funmap_search0 (i0funmap, i0id)
    val paralst = i0fundef_get_paralst (i0fundef)

    // remove reference para
    val paralst = list0_filter<i0id>(paralst,
                       lam id => ~type0_is_ref (i0id_get_type (id)))
  in
    list0_append (res, paralst)
  end
  }

  // mapping for parameters of reference types
  val ref_para_map = i0idmap_create (i2sz (1024))
  val cur_paralst = i0fundef_get_paralst (i0fundef)
  val cur_ref_paralst = 
    list0_filter<i0id>(cur_paralst,
                       lam id => type0_is_ref (i0id_get_type (id)))

  // process all the other functions in the group
  val ref_para_map = list0_foldright<i0id><i0idmap> (
    fnames, fopr, ref_para_map) where {

  fun fopr (the_name: i0id, res: i0idmap):<cloref1> i0idmap = let
     // val () = fprint (stderr_ref, "fill ref_para_map for function ")
     // val () = fprint_i0id (stderr_ref, the_name)
     // val () = fprint (stderr_ref, "\n")

  in
    // Skip since the current one has been processed previously.
    if the_name = fname then res  
    else let
      // val () = fprint (stderr_ref, "xxxxxxxxxxxxxxxx\n")
      val the_i0fundef = i0funmap_search0 (i0funmap, the_name)
      val the_paralst = i0fundef_get_paralst (the_i0fundef)
      val the_ref_paralst = list0_filter<i0id>(the_paralst,
                     lam id => type0_is_ref (i0id_get_type (id)))

      val () = loop_match (cur_ref_paralst
                         , the_ref_paralst
                         , res) where {
      fun loop_match (
                     // parameters of the current function being processed
                     cur_ref_paralst: i0idlst  
                     // parameters of the function in the group
                     , the_ref_paralst: i0idlst
                     , ref_para_map: i0idmap): void =
      case+ (cur_ref_paralst, the_ref_paralst) of
      | (cons0 (cur_para, cur_ref_paralst1), cons0 (para, ref_paralst1)) => let
        val () = i0idmap_insert_any (ref_para_map, para, cur_para)
        // val () = fprint (stderr_ref, "map ")
        // val () = fprint_i0id (stderr_ref, para)
        // val () = fprint (stderr_ref, " to ")
        // val () = fprint_i0id (stderr_ref, cur_para)
        // val () = fprint (stderr_ref, "\n")
      in 
        loop_match (cur_ref_paralst1, ref_paralst1, ref_para_map) 
      end
      | (nil0 (), nil0 ()) => ()
      | (_, _) => 
        exitlocmsg ("The number of parameters of ref types doesn't match.\n")
      }
    in
      res
    end  // end of [fopr]
    end
  }

  // create new parameters for the current function
  typedef para_old_new = @(i0id (*variable*), i0id (*parameter*))
  val para_pair_lst = list0_foldright<i0id><list0 para_old_new> (
                    cur_paralst, fopr, nil) where {
    fun fopr (i0id:i0id, res: list0 para_old_new):<cloref1> list0 para_old_new = let
      val type0 = i0id_get_type (i0id)
    in
      // for reference arg, two i0id's are identical.
      if type0_is_ref (type0) then let
        val res = list0_cons (@(i0id, i0id), res)
      in res end
      else let
        val new_i0id = i0id_copy (i0id, sa)
        val res = list0_cons (@(i0id, new_i0id), res)
      in res end
    end
  }

  val new_paralst = list0_foldright<para_old_new><i0idlst> (
                     para_pair_lst, lam (p, res) => p.1 :: res, nil)   

  // val () = fprint (stderr_ref, "========================== 01\n")
  // build an extra instruction for initialization
  // remove reference args from para_pair_lst
  val nonref_para_pair_lst = 
      list0_foldright<para_old_new><list0 para_old_new> (
      para_pair_lst, fopr, nil0 ()) where {
  fun fopr (para_pair: para_old_new
           , res: list0 para_old_new):<cloref1> list0 para_old_new = let
    val type0 = i0id_get_type (para_pair.0)
  in
    if type0_is_ref (type0) then res
    else cons0 (para_pair, res)
  end
  }

  // val () = fprint (stderr_ref, "========================== 20\n")
  // build tags for all the functions in the group
  // map function name to tag
  val map_fname_tag = i0idmap_create (i2sz(1024))
  val () = list0_foreach (fnames, fopr) where {
  fun fopr (i0id: i0id):<cloref1> void = let
    val new_id = i0id_copy_remove_prefix_inline (i0id, sa)
    val () = i0idmap_insert_any (map_fname_tag, i0id, new_id)
  in end
  }
  
  (* ****************** ************** *)

  // We process the current function first.

  // transform current function
  val cur_inss = i0fundef_get_instructions (i0fundef)
  
  // val () = fprint (stderr_ref, "========================== 30\n")
  val cur_inss = optimize_tailcall_recursivecall2jump (
    cur_inss, map_fname_tag, i0funmap, ref_para_map, sa)
  // val () = fprint (stderr_ref, "========================== 40\n")

  val ins_init = INS0init_loop (nonref_group_paralst, nonref_para_pair_lst)

  // build an extra instruction for the beginning label
  val- ~Some_vt(cur_tag) = i0idmap_search (map_fname_tag, fname)
  val ins_label = INS0label (cur_tag)

  val all_inss = list0_reverse_append (cur_inss, ins_label :: ins_init :: nil0)

  val label_end = i0id_var_copy_remove_prefix_inline_add_suffix (fname, "_end", sa)
  val ins_goto_end = INS0goto (label_end)
  val ins_end = INS0label (label_end)

  // Non-mutually recursive but recursive has no end label
  val all_inss = if (length (fnames) > 1) then ins_goto_end :: all_inss
                 else all_inss

  val all_inss = loop (fnames, all_inss) where {
  fun loop (fnames: i0idlst, res_inss: i0inslst): i0inslst =
    case+ fnames of
    | cons0 (the_name, fnames1) =>
    if the_name = fname then loop (fnames1, res_inss)  // skip the current function
    else let
      val i0fundef = i0funmap_search0 (i0funmap, the_name)
      val the_inss = i0fundef_get_instructions (i0fundef)
      val the_inss = i0inss_substitute_id (the_inss, ref_para_map)

      val the_inss = optimize_tailcall_recursivecall2jump (
        the_inss, map_fname_tag, i0funmap, ref_para_map, sa)

      val- ~Some_vt(tag) = i0idmap_search (map_fname_tag, the_name)
      val ins_label = INS0label (tag)
      val res_inss = list0_reverse_append (the_inss, ins_label :: res_inss)
      // val res_inss = ins_goto_end :: res_inss
    in
      case+ fnames1 of
      | cons0 (_, _) => loop (fnames1, ins_goto_end :: res_inss)
      | nil0 () => loop (fnames1, res_inss)
    end
    | nil0 () => res_inss
  }

  // Non-mutually recursive but recursive has no end label
  val all_inss = if (length (fnames) > 1) then ins_end :: all_inss
                 else all_inss

  val new_inss = list0_reverse (all_inss)

  val new_fundef = i0fundef_create (
    fname
    , new_paralst
    , new_inss
    , fnames
    )
in
  new_fundef
end  // end of [i0optimize_tailcall_fundef]

(* ************************* ************************** *)

implement i0ins_substitute_id (ins, idmap) = case+ ins of
| INS0decl (i0id, i0expopt) => 
  INS0decl (i0id_substitute_id (i0id, idmap)
          , i0expopt_substitute_id (i0expopt, idmap))
| INS0assign (i0expopt, i0exp) => 
  INS0assign (i0expopt_substitute_id (i0expopt, idmap)
            , i0exp_substitute_id (i0exp, idmap))
| INS0label (i0id) => 
  INS0label (i0id_substitute_id (i0id, idmap))
// | INS0return (i0expopt) => 
//   INS0return (i0expopt_substitute_id (i0expopt, idmap))
| INS0ifbranch (i0exp, i0inslst1 (*if*), i0inslst2 (*else*)) =>
  INS0ifbranch (i0exp_substitute_id (i0exp, idmap)
              , i0inss_substitute_id (i0inslst1, idmap)
              , i0inss_substitute_id (i0inslst2, idmap))
| INS0random (i0gbranchlst, inssopt) =>
  INS0random (i0gbranchlst_substitute_id (i0gbranchlst, idmap)
            , i0inssopt_substitute_id (inssopt, idmap))
| INS0goto (i0id) => 
  INS0goto (i0id_substitute_id (i0id, idmap))
| INS0exception () => ins
| INS0init_loop (_, _) => ins  // Currently no need to handle. exitlocmsg ("todo.")
| INS0tail_jump (_, _) => ins  // Currently no need to handle. exitlocmsg ("todo.")
// end of [i0ins_substitute_id]

(* ************************* ************************** *)

implement i0inss_substitute_id (inss(*: i0inslst*)
                                , idmap(*: i0idmap*)) =
  list0_map (inss, lam ins => i0ins_substitute_id (ins, idmap))

(* ************************* ************************** *)

implement i0inssopt_substitute_id (inssopt, idmap) =
  option0_map (inssopt, lam inss => i0inss_substitute_id (inss, idmap))

(* ************************* ************************** *)

implement i0exp_substitute_id (exp, idmap) = 
case+ exp of
| EXP0int _ => exp
| EXP0i0nt _ => exp
| EXP0string _ => exp
| EXP0var i0id => EXP0var (i0id_substitute_id (i0id, idmap))
| EXP0any () => exp
| EXP0app (fnameid, i0explst) =>
  EXP0app (i0id_substitute_id (fnameid, idmap)
         , i0explst_substitute_id (i0explst, idmap))
| EXP0extfcall (name, i0explst) => 
  EXP0extfcall (name, i0explst_substitute_id (i0explst, idmap))
| EXP0lambody i0exp => EXP0lambody (i0exp_substitute_id (i0exp, idmap))
| EXP0matchtag (de, ctor) =>
  EXP0matchtag (i0id_substitute_id (de, idmap)
              , i0id_substitute_id (ctor, idmap))
  
(* ************************* ************************** *)

implement i0explst_substitute_id (i0explst(*: i0explst*)
                                , idmap(*: i0idmap*)) =
  list0_map<i0exp><i0exp> (i0explst, 
      lam i0exp => i0exp_substitute_id (i0exp, idmap))

implement i0expopt_substitute_id (i0expopt, idmap) = 
  option0_map (i0expopt, lam i0exp => i0exp_substitute_id (i0exp, idmap))

(* ************************* ************************** *)

implement i0gbranch_substitute_id (i0gbranch, idmap) = let
  val i0inss = i0inss_substitute_id (
             i0gbranch.i0gbranch_inss, idmap)
  val guard = i0ins_substitute_id (i0gbranch.i0gbranch_guard, idmap)
  val i0gbranch' = i0gbranch_make (guard, i0inss)
in
  i0gbranch'
end

(* ************************* ************************** *)

implement i0id_substitute_id (id, idmap) = 
if i0id_is_any (id) || i0id_is_sym (id) then id  // These two have no stamps.
else let
  val idopt_vt = i0idmap_search (idmap, id)
in
  case+ idopt_vt of
  | ~Some_vt (id1) => id1
  | ~None_vt () => id
end

(* ************************* ************************** *)

implement i0gbranchlst_substitute_id (i0gbranchlst, idmap) = 
  list0_map (i0gbranchlst
     , lam i0gbranch => i0gbranch_substitute_id (i0gbranch, idmap))

(* ************************* ************************** *)

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
      if i0id_is_any (i0id) then let  // handle val _ = xxx
        val- Some0 i0exp = i0expopt
        val ins_assign = INS0assign (Some0 (EXP0any ()),  i0exp)
        val res2' = ins_assign :: res2
      in
        loop (i0inslst1, res1 (*no new INS0decl*), res2')
      end
      else
      (
      case+ i0expopt of
      | Some0 i0exp => let
        val ins_dec = INS0decl (i0id, None0)
        val ins_assign = INS0assign (Some0 (EXP0var i0id),  i0exp)
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
    // | INS0return (i0expopt) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0ifbranch (i0exp, i0inslst_if (*if*), i0inslst_else (*else*)) => let
      val (res1', inss_in_if) = loop (i0inslst_if, res1, nil0)
      val (res1'', inss_in_else) = loop (i0inslst_else, res1', nil0)
      val ins = INS0ifbranch (i0exp, inss_in_if, inss_in_else)
      val res2' = ins :: res2
    in
      loop (i0inslst1, res1'', res2')
    end
    | INS0random (i0gbranchlst, inssopt) => let
      typedef accu_t = 
        '(i0inslst (*for INS0decl*), i0gbranchlst (*for i0gbranch list*))
      val '(res1', i0gbranchlst') = 
        list0_foldright<i0gbranch><accu_t> (
          i0gbranchlst, fopr, '(res1, nil0 ())) where {
      fun fopr (i0gbranch: i0gbranch
                , '(res1, res2): accu_t):<cloref1> accu_t = let

        // Turn one ins into list
        val guard_inss0 = cons0 (i0gbranch.i0gbranch_guard, nil0 ())
        // Add decl if necessary
        val (res1', guard_inss1) = loop (guard_inss0, res1, nil0)
        // Shall have only one ins
        val- cons0 (guard_new, nil0 ()) = guard_inss1


        val (res1'', inss_in_branch) = 
          loop (i0gbranch.i0gbranch_inss, res1', nil0)

        val i0gbranch' = i0gbranch_make (guard_new, inss_in_branch)
      in
        '(res1'', cons0 (i0gbranch', res2))
      end
      }
    in
      case+ inssopt of
      | Some0 inss => let
        val (res1'', inss_in_else) = loop (inss, res1', nil0)
        val ins = INS0random (i0gbranchlst', Some0 inss_in_else)
        val res2' = ins :: res2
      in
        loop (i0inslst1, res1'', res2')
      end
      | None0 () => let
        val ins = INS0random (i0gbranchlst', None0 ())
        val res2' = ins :: res2
      in
        loop (i0inslst1, res1', res2')
      end
    end  // end of [INS0randome]
    | INS0goto (i0id) => loop (i0inslst1, res1, i0ins :: res2)
    | INS0exception () => loop (i0inslst1, res1, i0ins :: res2)
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
        val ins = INS0assign (Some0 (EXP0var tup.0), EXP0var (tup.1))
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

  
  
  

