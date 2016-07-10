


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../instr0/instr0.sats"
staload "./../postiats/postiats.sats"

#include "./../instr0/instr0_codegen2.hats"

#define :: list0_cons

#define EUs EUstring

(* ************ ************* *)

fun pml_name_make_startwith_prefix (i0id: i0id, pre: string): 
  option0 (pml_name) = let
  val fullname_str = tostring_i0id (i0id)
  val opt = fullname_str.removePrefix (pre)
in
  if (i0id_is_sym (i0id)) then None0 ()
  else let 
    // val () = fprintln! (stderr_ref, "begin p =====")
    val stamp = i0id_get_stamp (i0id)
    // val () = fprintln! (stderr_ref, "end p =====")
  in
    case+ opt of
    | Some (name_str) => let
      val type0 = i0id_get_type (i0id)

      // val () = fprintln! (stderr_ref, "begin p =====")
      // val () = fprint_i0id (stderr_ref, i0id)
      // val () = fprintln! (stderr_ref, "end p =====")
      val pml_type = pmltransform_i0type (type0)

      val pml_name = pml_name_make (name_str, stamp, pml_type, None0 ())
    in
      Some0 (pml_name)
    end
    | None () => None0 ()
  end
end

fun pml_name_make_inline (i0id: i0id): option0 (pml_name) = 
  pml_name_make_startwith_prefix (i0id, PML_INLINE)

fun pml_name_make_proctype (i0id: i0id): option0 (pml_name) =
  pml_name_make_startwith_prefix (i0id, PML_PROCTYPE)

fun pml_name_is_init (i0id: i0id): bool =
case+ pml_name_make_startwith_prefix (i0id, PML_INIT) of
| Some0 _ => true
| None0 () => false

(* ************ ************* *)
implement i0exp_is_inline_call (i0exp) =
case+ i0exp of
| EXP0app (i0id, _) => let
  val name_opt = pml_name_make_inline (i0id)
in
  case+ name_opt of
  | Some0 _ => true
  | None0 () => false
end
| _ => false

implement pml_varref_make (pml_name) =
  PMLVARREF (pml_name, None0, None0)

(* ************ ************* *)

implement pmltransform_i0prog (dtmap, i0prog) = let
  val infolst = datatype0map_listize (dtmap)
  typedef res_type = '(pml_modulelst, list0 pml_name)
  val '(modules, pml_names) = loop (infolst, '(nil0 (), nil0 ())) where {
  fun loop (dtinfolst: list0 datatype0info, res: res_type)
  :<cloref1> res_type = 
  case+ dtinfolst of
  | cons0 (dtinfo1, dtinfolst1) => let
    val uname = (s2cst_get_name (dtinfo1.datatype0info_name)).tostring ()
    val ustamp = s2cst_get_stamp (dtinfo1.datatype0info_name)
    val utype = PMLTYPE_ignore ()
    val utype_name = pml_name_make (uname, ustamp, utype, None0 ())
    
    // create a user defined type from a datatype in ATS
    val pml_declst = loop (dtinfo1.datatype0info_marshall, nil0 (), 0) where {
    fun loop (type0lst: type0lst, res: pml_declst, n: int):<cloref1> pml_declst =
    case+ type0lst of
    | cons0 (type0, type0lst1) => let
      val pml_type = pmltransform_i0type (type0)
      val pml_name = pml_name_make ("member", stamp_make (n), pml_type, None0 ())
      val pml_ivar = PMLIVAR_name (pml_name)
      val pml_ivarlst = list0_sing (pml_ivar)
      
      val pml_decl = pml_decl_make (None0 (), pml_type, pml_ivarlst)
      val res = cons0 (pml_decl, res)
    in
      loop (type0lst1, res, n + 1)
    end
    | nil0 () => res
    }
    val pml_declst = list0_reverse (pml_declst)

    // add the first member which is the tag for constructor
    val pml_type = PMLTYPE_mtype ()
    val pml_name = pml_name_make (
              PML_NAME_FOR_CTOR, stamp_make (0), pml_type, None0 ())
    val pml_ivar = PMLIVAR_name (pml_name)
    val pml_ivarlst = list0_sing (pml_ivar)
    val pml_decl_ctor = pml_decl_make (None0 (), pml_type, pml_ivarlst)
    val pml_declst = cons0 (pml_decl_ctor, pml_declst)

    val module_utype = PMLMODULE_utype (utype_name, pml_declst)
    val module_utypelst = cons0 (module_utype, res.0)

    val pml_namelst = list0_foldleft<type0ctor><list0 pml_name> (
      dtinfo1.datatype0info_ctors, nil0 (), fopr) where {
    fun fopr (res: list0 pml_name, e: type0ctor):<cloref1> list0 pml_name = let
      val i0id = e.0
      val pml_name = pmltransform_i0id (i0id)
      val res = cons0 (pml_name, res)
    in
      res
    end
    }
    val pml_namelst = list0_reverse_append (pml_namelst, res.1)
    val res = '(module_utypelst, pml_namelst)
  in
    loop (dtinfolst1, res)
  end
  | nil0 () => res
  // end of [loop]
  }

  val module_mtype = PMLMODULE_mtype (pml_names)
  val modules_type = list0_reverse_append (modules, list0_sing (module_mtype))
// type0ctor = '(d2con (*constructor*), list0 ('(int (*mapped position*), type0)))

// typedef pml_decl = '{
//   pml_decl_visible = option0 bool
//   , pml_decl_type = pml_type
//   , pml_decl_ivarlst = pml_ivarlst
// }

// datatype
// pml_ivar = 
// | PMLIVAR_exp of (pml_name (* bool (is constant)*), pml_exp)
// | PMLIVAR_chan of (pml_name (* bool (is constant)*), pml_chan_init)
// | PMLIVAR_name of (pml_name)
   

// assume pml_name = '{
//   pml_name_name = string
//   , pml_name_stamp = stamp
//   , pml_name_type = pml_type
// }

// /* user defined types */
// | PMLMODULE_utype of (pml_name, pml_declst)
// /* mtype declaration */
// | PMLMODULE_mtype of (list0 symbol)
    
// typedef datatype0info = 
// '{ datatype0info_name = s2cst
//  , datatype0info_marshall = type0lst
//  , datatype0info_ctors = type0ctorlst
// }

  val funmap = i0prog.i0prog_i0funmap
  val i0declst = i0prog.i0prog_i0declst
  
  val modules = list0_foldright (i0declst, fopr, nil0) where {
    fun fopr (x: i0decl, res: pml_modulelst):<cloref1> pml_modulelst = let
      val pml_module = pmltransform_i0decl (x)
    in
      pml_module :: res
    end
  }

  val modules = list0_reverse_append (modules_type, modules)
in
  modules
end

implement pmltransform_i0decl (i0decl) =
case+ i0decl of
| DEC0fun (i0fundef) => pmltransform_i0fundef (i0fundef)
| DEC0extcode (code) => PMLMODULE_literal_code (code)
| DEC0gvar _ => exitlocmsg (" DEC0gvar is not supported")

implement pmltransform_i0fundef (i0fundef) = let
  val i0id = i0fundef_get_id (i0fundef)
  val pml_name_opt = pml_name_make_proctype (i0id)
in
  case+ pml_name_opt of
  | Some0 (pml_name) => pmltransform_proctype (pml_name, i0fundef)
  | None0 () => let
  val pml_name_opt = pml_name_make_inline (i0id)
in
  case+ pml_name_opt of
  | Some0 (pml_name) => pmltransform_inline (pml_name, i0fundef)
  | None0 () => if pml_name_is_init (i0id) then
                  pmltransform_init (i0fundef)
                else exitlocmsg ("Only proctype$, inline$, and pml$init \
are supported.\n")
end
end

implement pmltransform_inline (pml_name, i0fundef) = let
  // paralst
  val i0idlst = i0fundef_get_paralst (i0fundef)
  val pml_namelst = list0_foldright (i0idlst, fopr, nil0) where {
    fun fopr (i0id: i0id, res: list0 pml_name):<cloref1> list0 pml_name = let
      val pml_name = pmltransform_i0id (i0id)
    in
      pml_name :: res
    end
  }

  val inss = i0fundef_get_instructions (i0fundef)
  val pml_steplst = pmltransform_i0inslst (true, inss)

  val inline = pml_inline_make (pml_name, pml_namelst, pml_steplst)
in
  PMLMODULE_inline (inline)
end


implement pmltransform_proctype (pml_name, i0fundef) = let
  // paralst
  val i0idlst = i0fundef_get_paralst (i0fundef)
  val pml_declst = list0_foldright (i0idlst, fopr, nil0) where {
    fun fopr (i0id: i0id, res: pml_declst):<cloref1> pml_declst = let
      val pml_name = pmltransform_i0id (i0id)
      val pml_ivar = PMLIVAR_name pml_name
      val pml_ivarlst = pml_ivar :: nil0

      val pml_type = pml_name_get_type (pml_name)

      val pml_decl = pml_decl_make (Some0 false, pml_type, pml_ivarlst)
    in
      pml_decl :: res
    end
  }

  val inss = i0fundef_get_instructions (i0fundef)
  val pml_steplst = pmltransform_i0inslst (false, inss)

  val proctype = pml_proctype_make (pml_name, pml_declst, pml_steplst)
in
  PMLMODULE_proctype (proctype)
end

implement pmltransform_init (i0fundef) = let
  val inss = i0fundef_get_instructions (i0fundef)
  val pml_steplst = pmltransform_i0inslst (false, inss)
in
  PMLMODULE_init pml_steplst
end

implement pmltransform_i0id (i0id) = let
  val name = tostring_i0id (i0id)
  // val () = fprintln! (stderr_ref, "begin =====")
  val stamp = i0id_get_stamp i0id
  // val () = fprintln! (stderr_ref, "end =====")

  val type0 = i0id_get_type (i0id)

  // val () = fprintln! (stderr_ref, "begin p2 =====")
  // val () = fprint_i0id (stderr_ref, i0id)
  // val () = fprintln! (stderr_ref, "end p2 =====")

  val pml_type = pmltransform_i0type (type0)
in
  pml_name_make (name, stamp, pml_type, i0id_get_extdef (i0id))
end

implement pmltransform_i0inslst (is_inline, i0inslst) = let
fun loop (i0inslst: i0inslst, res: pml_steplst): pml_steplst =
case+ i0inslst of
| i0ins :: i0inslst => (
  case+ i0ins of
  | INS0decl (i0id, i0expopt) => let
    val pml_name = pmltransform_i0id (i0id)
    val pml_type = pml_name_get_type (pml_name)

    val pml_ivar = (case+ i0expopt of
      | Some0 i0exp => let
        val pml_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
        val pml_exp = PMLEXP_anyexp (pml_anyexp)
      in
        PMLIVAR_exp (pml_name, pml_exp)
      end
      | None0 () => PMLIVAR_name (pml_name)
    )
    val pml_ivarlst = pml_ivar :: nil0
    val pml_decl = pml_decl_make (Some0 false (*visible*), pml_type, pml_ivarlst)
    val pml_declst = pml_decl :: nil0
    val pml_step = PMLSTEP_declst pml_declst
  in 
    loop (i0inslst, pml_step :: res)
  end
  | INS0assign (i0exp_opt, i0exp) => (
    if i0exp_is_inline_call (i0exp) then 
      (
      case+ i0exp_opt of  // handle inline call
      | Some0 (i0exp) => exitlocmsg ("inline function has no return value")
      | None0 () => let 
        val pml_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
        val pml_exp = PMLEXP_anyexp (pml_anyexp)
        val pml_stmnt = PMLSTMNT_exp (pml_exp)
        val pml_step = PMLSTEP_stmnt (pml_stmnt)
      in
        loop (i0inslst, pml_step :: res)
      end
      )
    else case+ i0exp_opt of
    | Some0 (i0exp_name) => let  // handle normal expression
      // Currently, the left hand side must be a name.
      val- EXP0var (i0id) = i0exp_name  
      val pml_name = pmltransform_i0id (i0id)
      val pml_varref = PMLVARREF (pml_name, None0, None0)
      val pml_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
      val pml_stmnt = PMLSTMNT_assign (pml_varref, pml_anyexp)
      val pml_step = PMLSTEP_stmnt pml_stmnt
    in
      loop (i0inslst, pml_step :: res)
    end
    | None0 () => let // hande normal function call without return value
      val pml_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
      val pml_exp = PMLEXP_anyexp (pml_anyexp)
      val pml_stmnt = PMLSTMNT_exp (pml_exp)
      val pml_step = PMLSTEP_stmnt (pml_stmnt)
    in
      loop (i0inslst, pml_step :: res)
    end
    )  // end of [if i0exp_is_inline_call]
  | INS0return i0expopt => 
    (
    case+ i0expopt of
    | Some0 (i0exp) => let // hande normal function call without return value
      val pml_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
      val pml_exp = PMLEXP_anyexp (pml_anyexp)
      val pml_stmnt = PMLSTMNT_exp (pml_exp)
      val pml_step = PMLSTEP_stmnt (pml_stmnt)
    in
      loop (i0inslst, pml_step :: res)
    end
    | None0 () => loop (i0inslst, res)
    )
  | INS0init_loop (local_vars, assignments) => 
    exitlocmsg ("This should not happen. \
INS0init_loop is replaced by dec and assign")
  // let
  //   val res = list0_foldleft (local_vars, res, fopr) where {
  //     fun fopr (pml_steplst: pml_steplst
  //               , i0id: i0id):<cloref1> pml_steplst = let
  //       val pml_dec = pmltransform_i0id2decl (i0id)
  //       val pml_declst = pml_dec :: nil0
  //       val pml_step = PMLSTEP_declst pml_declst
  //     in
  //       pml_step :: res
  //     end
  //   }
  //   // todo
  // in
  //   loop (i0inslst, res)
  // end
  | INS0label (i0id) => let
    val pml_name = pmltransform_i0id (i0id)
    val- ins1 :: inss1 = i0inslst
    val steps = pmltransform_i0inslst (is_inline, ins1 :: nil0)
    val- step1 :: steps1 = steps

    // consume the next stmnt
    val- PMLSTEP_stmnt (stmnt) = step1  // It should be a statement.
    val pml_stmnt = PMLSTMNT_name (pml_name, stmnt)
    val pml_step = PMLSTEP_stmnt (pml_stmnt)
    val res = pml_step :: res
    val res = list0_reverse_append (steps1, res)
  in
    loop (inss1, res)
  end
  | INS0tail_jump (epiloge_inss, i0id) => let
    val epiloge_steps = pmltransform_i0inslst (is_inline, epiloge_inss)
    val res = list0_reverse_append (epiloge_steps, res)
    val pml_name = pmltransform_i0id (i0id)
    val pml_stmnt = PMLSTMNT_goto (pml_name)
    val pml_step = PMLSTEP_stmnt (pml_stmnt)
    val res = pml_step :: res
  in
    loop (i0inslst, res)
  end
  | INS0ifbranch (i0exp, inss_if, inss_else) => let
    val guard_anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
    val guard_exp = PMLEXP_anyexp (guard_anyexp)

    val guard_step = PMLSTEP_stmnt (PMLSTMNT_exp (guard_exp))
    val pml_inss_if = pmltransform_i0inslst (is_inline, inss_if)
    val pml_inss_if = guard_step :: pml_inss_if

    val else_step = PMLSTEP_stmnt (PMLSTMNT_else)
    val pml_inss_else = pmltransform_i0inslst (is_inline, inss_else)
    val pml_inss_else = else_step :: pml_inss_else

    val pml_stmnt = PMLSTMNT_if (pml_inss_if :: pml_inss_else :: nil0)
    val pml_step = PMLSTEP_stmnt (pml_stmnt)
    val res = pml_step :: res
  in
    loop (i0inslst, res)
  end
  | INS0random (i0gbranchlst, inssopt) => let
      val branches = list0_foldright<i0gbranch><pml_options> (
          i0gbranchlst, fopr, nil0) where {
      fun fopr (i0gbranch: i0gbranch, res: pml_options):<cloref1> pml_options = let
        val guard_anyexp = 
          pmltransform_i0exp2pml_anyexp (i0gbranch.i0gbranch_guard)
        val guard_exp = PMLEXP_anyexp (guard_anyexp)
        val guard_step = PMLSTEP_stmnt (PMLSTMNT_exp (guard_exp))

        val pml_inss = pmltransform_i0inslst (is_inline, i0gbranch.i0gbranch_inss)
        val pml_inss = guard_step :: pml_inss

        val res = pml_inss :: res
      in
        res
      end
      }
    in
      case+ inssopt of
      | Some0 inss_else => let
        val else_step = PMLSTEP_stmnt (PMLSTMNT_else)
        val pml_inss_else = pmltransform_i0inslst (is_inline, inss_else)
        val pml_inss_else = else_step :: pml_inss_else

        val pml_stmnt = 
          PMLSTMNT_if (list0_append (branches, pml_inss_else :: nil0))
        val pml_step = PMLSTEP_stmnt (pml_stmnt)
        val res = pml_step :: res
      in
        loop (i0inslst, res)
      end
      | None0 () => let
        val pml_stmnt = 
          PMLSTMNT_if (branches)
        val pml_step = PMLSTEP_stmnt (pml_stmnt)
        val res = pml_step :: res
      in
        loop (i0inslst, res)
      end
    end  // end of [INS0randome]
  | INS0exception () => let
    val pml_exp = PMLEXP_anyexp (PMLANYEXP_const (PMLATOM_bool (false)))
    val pml_stmnt = PMLSTMNT_assert (pml_exp)
    val pml_step = PMLSTEP_stmnt (pml_stmnt)
  in
    loop (i0inslst, pml_step :: res)
  end // end of [INS0exception]
  | _ => exitlocmsg ("todo: " + datcon_i0ins i0ins)
)  // end of [i0ins :: i0inslst]
| nil0 () => res

val pml_inss = loop (i0inslst, nil0)
val ret = list0_reverse (pml_inss)
in
  ret
end

implement pmltransform_i0type (type0) =
case+ type0 of
| TYPE0int () => PMLTYPE_int
| TYPE0char () => PMLTYPE_byte
| TYPE0bool () => PMLTYPE_short
| TYPE0unit () => exitlocmsg ("Check this.\n")
| TYPE0fun (type0lst, type0) => PMLTYPE_ignore
| TYPE0ref (type0) => pmltransform_i0type (type0)
| TYPE0name (s2cst) => let
  val name = (s2cst_get_name (s2cst)).tostring ()
in
  case+ name of
  | "pid" => PMLTYPE_pid ()
  | "pml$lock" => PMLTYPE_int
  | str => PMLTYPE_uname (pml_uname_create (s2cst_get_name (s2cst)))
      // exitlocmsg (str + " is countered. Check this.\n")
end
| TYPE0ignored () => PMLTYPE_ignore ()

implement pmltransform_i0exp2pml_anyexp (i0exp) =
case+ i0exp of
| EXP0int (i) => exitlocmsg ("not supported")  // PMLANYEXP_const (PMLATOM_int (i))
| EXP0i0nt (i_str) => PMLANYEXP_const (PMLATOM_i0nt (i_str))
| EXP0string (str) => PMLANYEXP_string (str)
| EXP0var (i0id) => 
      PMLANYEXP_varref (pml_varref_make (pmltransform_i0id (i0id)))
| EXP0app (i0id, i0explst) => let
  val opr_opt = pmltransform_i0id2operator (i0id)
in
  case+ opr_opt of
  | Some0 (opr) =>
    (
      case+ i0explst of
      | arg1 :: i0explst1 => let
        val pml_arg1 = pmltransform_i0exp2pml_anyexp (arg1)
      in
        (
        case+ i0explst1 of
        | arg2 :: _ => let
          val pml_arg2 = pmltransform_i0exp2pml_anyexp (arg2)
          val pml_anyexp = PMLANYEXP_binarop (opr, pml_arg1, pml_arg2)
        in
          pml_anyexp
        end
        | nil0 () => let
          val pml_anyexp = PMLANYEXP_unarop (opr, pml_arg1)
        in
          pml_anyexp
        end
        )
      end
      | nil0 () => exitlocmsg ("Nullary operator is not supported.")
    )
  | None0 () => if i0id_is_run (i0id) then let
    val- i0exp :: nil0 = i0explst
    val- EXP0lambody (proc_call) = i0exp
    val- EXP0app (proc_id, proc_arglst) = proc_call
    val- Some0 proc_name = pml_name_make_proctype (proc_id)
    val pml_anyexplst = pmltransform_i0explst2pml_anyexplst (proc_arglst)
  in 
    PMLANYEXP_run (proc_name, pml_anyexplst)
  end // end of [i0id_is_run]
  else if i0id_is_wait_until (i0id) then let
    val- i0exp :: nil0 = i0explst
    val- EXP0lambody (i0exp_cond) = i0exp
    val anyexp = pmltransform_i0exp2pml_anyexp (i0exp_cond)
  in 
    anyexp
  end
    
  else let // not "run" in promela
    val name_opt = pml_name_make_inline (i0id)
    val pml_anyexplst = pmltransform_i0explst2pml_anyexplst (i0explst)
  in
  case+ name_opt of  // check whether is inline
  // is inline function (named by inline$xxx)
  | Some0 (name) => let
    val extname_opt = i0id_get_extdef (i0id)
  in
    (
    case+ extname_opt of
    | Some0 extname => PMLANYEXP_inline (
                     pmltransform_i0id (i0id), pml_anyexplst)
    | None0 () => PMLANYEXP_inline (name, pml_anyexplst)
    )
  end
  // is not inline function
  | None0 () => let
    val name = tostring_i0id (i0id)
  in
    PMLANYEXP_fcall (name, pml_anyexplst)
  end
  
  end
end
| EXP0extfcall (name, i0explst) => let
  val pml_anyexplst = pmltransform_i0explst2pml_anyexplst (i0explst)
in
  PMLANYEXP_fcall (name, pml_anyexplst)
end
| EXP0lambody _ => exitlocmsg (
  "This should not happen. Run should be processed else where")
| EXP0matchtag (elename, ctorname) => let
  val pml_elename = pmltransform_i0id (elename)

  val varref_index = pml_varref_make (pml_name_tag)
  val varref = PMLVARREF (pml_elename, None0 (), Some0 varref_index)
  val pml_eleexp = PMLANYEXP_varref (varref)

  val pml_ctorname = pmltransform_i0id (ctorname)
  val pml_ctorvarref = pml_varref_make (pml_ctorname)
  val pml_ctorexp = PMLANYEXP_varref (pml_ctorvarref)

in
  PMLANYEXP_binarop (PMLOPR_eq (), pml_eleexp, pml_ctorexp)
end

implement pmltransform_i0explst2pml_anyexplst (i0explst) = let
  val ret = list0_foldright<i0exp> (i0explst, fopr, nil0) where {
  fun fopr (i0exp: i0exp, res: pml_anyexplst):<cloref1> pml_anyexplst = let
    val anyexp = pmltransform_i0exp2pml_anyexp (i0exp)
  in
    anyexp :: res
  end
  }
in
  ret
end

implement pmltransform_i0id2operator (i0id) = 
if i0id_is_sym (i0id) then let
  val opr_str = tostring_i0id_name (i0id)
in
  case+ opr_str of
  | "+" => Some0 PMLOPR_plus
  | "-" => Some0 PMLOPR_minus
  | "*" => Some0 PMLOPR_mul
  | "/" => Some0 PMLOPR_div
  | ">" => Some0 PMLOPR_gt
  | ">=" => Some0 PMLOPR_gte
  | "<" => Some0 PMLOPR_lt
  | "<=" => Some0 PMLOPR_lte
  | "&&" => Some0 PMLOPR_and
  | "||" => Some0 PMLOPR_or
  | "=" => Some0 PMLOPR_eq
  | "~" => Some0 PMLOPR_neg
//  | PML_RUN => Some0 PMLOPR_run
  | _ => exitlocmsg ("operator " + opr_str + " is not supported")
end
else None0


implement i0id_is_run (i0id) = let
  val opr_str = tostring_i0id_name (i0id)
in
  opr_str = PML_RUN
end

implement i0id_is_wait_until (i0id) = let
  val opr_str = tostring_i0id_name (i0id)
in
  opr_str = PML_WAIT_UNTIL
end

implement pmltransform_i0id2decl (i0id) = let
  val pml_name = pmltransform_i0id (i0id)
  val pml_ivar = PMLIVAR_name (pml_name)
  val pml_ivarlst = pml_ivar :: nil0

  val pml_type = pml_name_get_type (pml_name)
  val pml_decl = pml_decl_make (Some0 false (*visible*), pml_type, pml_ivarlst)

in
  pml_decl
end








