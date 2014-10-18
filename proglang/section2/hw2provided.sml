(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* Problem 1 *)
fun all_except_option(s, []) = NONE
  | all_except_option(s, x::xs) = 
      if same_string(s, x) then SOME xs
      else case all_except_option(s, xs) of
             NONE => NONE
           | SOME li => SOME (x::li)

(* Problem 2 *)
fun get_substitutions1([], s) = []
  | get_substitutions1(sl::sll, s) =
      let val sub = all_except_option(s, sl) 
      in case sub of
           NONE => get_substitutions1(sll, s)
         | SOME sl_result => sl_result @ get_substitutions1(sll, s) 
      end

(* Problem 3 *)
fun get_substitutions2(substitutions, s) =
  let fun aux(s_list_list, acc_list) = 
  case s_list_list of
    [] => acc_list
  | sl::sll => let val sub = all_except_option(s, sl)
               in case sub of
                    NONE => aux(sll, acc_list)
                  | SOME sl_result => aux(sll, acc_list @ sl_result)
               end
  in
    aux(substitutions, [])
  end

(* Problem 4 *)
fun similar_names(substitutions, {first=fname, middle=mname, last=lname}) =
  let fun aux(s_list, acc_list) = 
    case s_list of
      [] => acc_list
    | s::sl => aux(sl, acc_list @ [{first=s, middle=mname, last=lname}])
  in
    aux(get_substitutions2(substitutions, fname), [{first=fname, middle=mname, last=lname}])
  end

(* Problem 5 *)
fun card_color(acard) =
  case acard of
    (Clubs, _) => Black
  | (Spades, _) => Black
  | (Diamonds, _) => Red
  | (Hearts, _) => Red

(* Problem 6 *)
fun card_value(acard) =
  case acard of
    (_, Jack) => 10
  | (_, Queen) => 10
  | (_, King) => 10
  | (_, Ace) => 11
  | (_, Num i) => i

(* Problem 7 *)
fun remove_card(cs, c, e) =
  let fun remove_list(init_list, acc) =
    case init_list of
      [] => raise e
    | x::xs => if x = c then acc @ xs
               else remove_list(xs, acc @ [x])
  in
    remove_list(cs, [])
  end

(* Problem 8 *)
fun all_same_color(cs) =
  case cs of
    [] => true
  | x::[] => true
  | x1::x2::xs => if card_color(x1) = card_color(x2) 
                  then true andalso all_same_color(x2::xs)
                  else false

(* Problem 9 *)
fun sum_cards(cs) =
  let fun sumaux(c_list, acc) =
    case c_list of
      [] => acc
    | x::xs => sumaux(xs, card_value(x) + acc)
  in
    sumaux(cs, 0)
  end

(* Problem 10 *)
fun score(cs, goal) = 
  let 
    val pscore = let val sum = sum_cards(cs)
                 in if sum >= goal then 3 * (sum - goal)
                    else goal - sum
                 end
  in
    if all_same_color(cs) then pscore div 2
    else pscore
  end

(* Problem 11 *)
fun officiate(cards, moves, goal) = 
  let 
    fun make_move(cards_list, left_move, held_cards) =
      if sum_cards(held_cards) > goal 
      then score(held_cards, goal)
      else case left_move of
             [] => score(held_cards, goal)
           | Discard c::tail_move =>
               make_move(cards_list, tail_move, remove_card(held_cards, c, IllegalMove))
           | Draw::tail_move => 
               case cards_list of
                 [] => score(held_cards, goal)
               | x::xs => make_move(xs, tail_move, x::held_cards)
  in
    make_move(cards, moves, [])
  end

(* Problem 12 *)
fun sum_cards2(cs) =
  let fun sum_ace_aux(c_list, acc, ace_count) =
    case c_list of
      [] => (acc, ace_count)
    | x::xs => case x of
                 (_, Ace) => sum_ace_aux(xs, card_value(x) + acc - 10, ace_count + 1)
               | _ => sum_ace_aux(xs, card_value(x) + acc, ace_count)
  in
    sum_ace_aux(cs, 0, 0)
  end

fun score_challenge(cs, goal) =
  let val (sum_init, ace_count) = sum_cards2(cs)
    fun score_by_sum(sum) =
      let 
        val pscore = 
          if sum >= goal then 3 * (sum - goal)
          else goal - sum
      in
        if all_same_color(cs) then pscore div 2
        else pscore
      end
    fun score_try(score_acc, ace_count_acc) =
      if ace_count_acc = 0 then score_acc
      else let val score_now = score_by_sum(sum_init + ace_count_acc * 10)
        in
          if score_now < score_acc then score_try(score_now, ace_count_acc - 1)
          else score_try(score_acc, ace_count_acc - 1)
        end
  in
    score_try(score_by_sum(sum_init), ace_count)
  end

fun officiate_challenge(cards, moves, goal) =
  let 
    fun make_move(cards_list, left_move, held_cards) =
      let val (sum_little, ace_count) = sum_cards2(held_cards)
      in
        if sum_little > goal
        then score_challenge(held_cards, goal)
        else case left_move of
               [] => score_challenge(held_cards, goal)
             | Discard c::tail_move =>
                 make_move(cards_list, tail_move, remove_card(held_cards, c, IllegalMove))
             | Draw::tail_move => 
                 case cards_list of
                   [] => score_challenge(held_cards, goal)
                 | x::xs => make_move(xs, tail_move, x::held_cards)
      end
  in
    make_move(cards, moves, [])
  end
