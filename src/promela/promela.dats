


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../instr0/instr0.sats"

#include "./../instr0/instr0_codegen2.hats"

#define :: list0_cons

#define EUs EUstring

(* ************ ************* *)

fun pml_name_make_startwith_prefix (i0id: i0id, pre: string): 
  option0 (pml_name) = let
  val fullname_str = tostring_i0id (i0id)
  val opt = fullname_str.removePrefix (pre)
  val stamp = i0id_get_stamp i0id
in
  case+ opt of
  | Some (name_str) => let
    val pml_name = pml_name_make (name_str, stamp, PMLTYPE_todo)
  in
    Some0 (pml_name)
  end
  | None () => None0 ()
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

implement pmltransform_i0prog (i0prog) = let
  val funmap = i0prog.i0prog_i0funmap
  val i0declst = i0prog.i0prog_i0declst
  
  val modules = list0_foldright (i0declst, fopr, nil0) where {
    fun fopr (x: i0decl, res: pml_modulelst):<cloref1> pml_modulelst = let
      val pml_module = pmltransform_i0decl (x)
    in
      pml_module :: res
    end
  }
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
                else exitlocmsg ("Not supported.")
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

      val pml_decl = pml_decl_make (false, pml_type, pml_ivarlst)
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
  val stamp = i0id_get_stamp i0id
  val type = pmltransform_i0type ()
in
  pml_name_make (name, stamp, type)
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
    val pml_decl = pml_decl_make (false (*visible*), pml_type, pml_ivarlst)
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
    | Some0 (i0exp) => 
      if ~is_inline then exitlocmsg ("non-inline function cannot return value.")
      else exitlocmsg ("todo")
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
    val steps = pmltransform_i0inslst (false, ins1 :: nil0)
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
    val epiloge_steps = pmltransform_i0inslst (false, epiloge_inss)
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
    val pml_inss_if = pmltransform_i0inslst (false, inss_if)
    val pml_inss_if = guard_step :: pml_inss_if

    val else_step = PMLSTEP_stmnt (PMLSTMNT_else)
    val pml_inss_else = pmltransform_i0inslst (false, inss_else)
    val pml_inss_else = else_step :: pml_inss_else

    val pml_stmnt = PMLSTMNT_if (pml_inss_if :: pml_inss_else :: nil0)
    val pml_step = PMLSTEP_stmnt (pml_stmnt)
    val res = pml_step :: res
  in
    loop (i0inslst, res)
  end
  | _ => exitlocmsg ("todo: " + datcon_i0ins i0ins)
)  // end of [i0ins :: i0inslst]
| nil0 () => res

val pml_inss = loop (i0inslst, nil0)
val ret = list0_reverse (pml_inss)
in
  ret
end

implement pmltransform_i0type () = PMLTYPE_todo

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
  end // end of [i0i
    
  else let // not "run" in promela
    val pml_anyexplst = pmltransform_i0explst2pml_anyexplst (i0explst)
    val name_opt = i0id_get_extdef (i0id)
  in
    case+ name_opt of  // check whether has external name
    | Some0 (name) => PMLANYEXP_fcall (name, pml_anyexplst)
    | None0 () => let
      val name_opt = pml_name_make_inline (i0id)
    in
      case+ name_opt of  // check whether is inline
      | Some0 (name) => PMLANYEXP_inline (name, pml_anyexplst)
      | None0 () => let
        val name = tostring_i0id (i0id)
      in
        PMLANYEXP_fcall (name, pml_anyexplst)
      end
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
  val pml_decl = pml_decl_make (false (*visible*), pml_type, pml_ivarlst)

in
  pml_decl
end








