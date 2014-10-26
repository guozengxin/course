(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals (xs) = List.filter(fn s => Char.isUpper(String.sub(s, 0))) xs

fun longest_string1 xs = List.foldl(fn (s1, s2) => if String.size(s1) > String.size(s2) then s1 else s2) "" xs

fun longest_string2 xs = List.foldl(fn (s1, s2) => if String.size(s1) >= String.size(s2) then s1 else s2) "" xs

fun longest_string_helper f xs = List.foldl(fn (s1, s2) => if f(String.size(s1), String.size(s2)) then s1 else s2) "" xs

val longest_string3 = longest_string_helper (fn (i1, i2) => i1 > i2)

val longest_string4 = longest_string_helper (fn (i1, i2) => i1 >= i2)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o rev o String.explode

fun first_answer f xs =
  case xs of
    [] => raise NoAnswer
  | x::xs' => case f(x) of
                SOME v => v
              | NONE => first_answer f xs'

fun all_answers f xs =
  let fun all_answers_helper(tlxs) =
  case tlxs of [] => SOME []
  | x::xs' => case f(x) of
                NONE => NONE
              | SOME v => case all_answers_helper(xs') of
                            SOME rl => SOME (v @ rl)
                          | NONE => NONE
  in 
    all_answers_helper(xs)
  end

val count_wildcards = g (fn _ => 1) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn _ => 1) (fn s => String.size(s))

fun count_some_var(s, p) = g (fn _ => 0) (fn s1 => if s1 = s then 1 else 0) p

fun check_pat p =
  let fun all_variables_string(p) =
	case p of
	    Wildcard          => []
	  | Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p', acc) => acc @ all_variables_string(p')) [] ps
	  | ConstructorP(_,p') => all_variables_string(p')
	  | _                 => []

    fun is_repeated(xs) =
      case xs of
        [] => true
      | x::xs' => if List.exists (fn y => y =x) xs' then false
                  else is_repeated(xs')
  in
    is_repeated(all_variables_string(p))
  end


fun match (value, pattern) =
  case (value, pattern) of
    (_, Wildcard) => SOME []
  | (v, Variable s) => SOME [(s, v)]
  | (Unit, UnitP) => SOME []
  | (Const i, ConstP pi) => if i = pi then SOME [] else NONE
  | (Tuple tv, TupleP tp) => 
      if List.length(tv) <> List.length(tp) then NONE
      else all_answers match (ListPair.zip(tv, tp))
  | (Constructor (vs, v), ConstructorP(ps, p)) => 
      if vs = ps then match (v, p)
      else NONE
  | (_, _) => NONE

fun first_match value pattern_list =
  SOME (first_answer (fn p => match(value, p)) pattern_list)
    handle NoAnswer => NONE
