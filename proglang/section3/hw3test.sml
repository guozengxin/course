(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3solution.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test1_1 = only_capitals ["A","b","C"] = ["A","C"]

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test2_1 = longest_string1 [] = ""

val test2_2 = longest_string1 ["abc","bc"] = "abc"

val test2_3 = longest_string1 ["a","bc","de"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test3_1 = longest_string2 ["A","bc","CD"] = "CD"

val test3_2 = longest_string2 [] = ""

val test4a= longest_string3 ["A","bc","C"] = "bc"

val test4b= longest_string4 ["A","B","C"] = "C"

val test4_1 = longest_string3 [] = ""

val test4_2 = longest_string3 ["abc","bc"] = "abc"

val test4_3 = longest_string3 ["a","bc","de"] = "bc"

val test4_4 = longest_string4 ["A","bc","C"] = "bc"

val test4_5 = longest_string4 ["A","bc","CD"] = "CD"

val test4_6 = longest_string4 [] = ""

val test5 = longest_capitalized ["A","bc","C"] = "A";

val test5_1 = longest_capitalized ["A","Bc","C"] = "Bc";

val test5_2 = longest_capitalized ["a","bc","C"] = "C";

val test5_3 = longest_capitalized ["a","bc","c"] = "";

val test5_4 = longest_capitalized [] = "";

val test6 = rev_string "abc" = "cba";

val test6_1 = rev_string "a" = "a";

val test6_2 = rev_string "" = "";

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test7_1 = ((first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5]; false)
  handle NoAnswer => true)

val test7_2 = first_answer (fn x => if x > 0 then SOME x else NONE) [1,2,3,4,5] = 1

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test8_1 = all_answers (fn x => if x = 2 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test8_2 = all_answers (fn x => if x > 0 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]

val test8_3 = all_answers (fn x => if x = 2 then SOME [x] else NONE) [] = SOME []

val test9a = count_wildcards Wildcard = 1

val test9a_1 = count_wildcards (TupleP [Wildcard, ConstructorP ("1", Wildcard)]) = 2

val test9a_2 = count_wildcards (Variable("a")) = 0

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9b_1 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc")]) = 4

val test9b_2 = count_wild_and_variable_lengths Wildcard = 1

val test9b_3 = count_wild_and_variable_lengths (TupleP []) = 0

val test9c = count_some_var ("x", Variable("x")) = 1;

val test9c_2 = count_some_var ("p", Variable("x")) = 0;

val test9c_3 = count_some_var ("p", TupleP []) = 0;

val test10 = check_pat (Variable("x")) = true

val test10_1 = check_pat (TupleP [Variable("x"), ConstructorP ("1", Variable("x"))]) = false

val test10_2 = check_pat (TupleP [Variable("x"), ConstructorP ("1", Variable("y"))]) = true

val test10_3 = check_pat (TupleP []) = true

val test10_4 = check_pat (ConstructorP ("hi",TupleP[Variable "x",ConstructorP ("yo",TupleP[Variable "x",UnitP])])) = false

val test11 = match (Const(1), UnitP) = NONE

val test11_1 = match (Const(1), ConstP(1)) = SOME []

val test11_2 = match (Const(1), Wildcard) = SOME []

val test11_3 = match (Unit, Variable("x")) = SOME [("x", Unit)]

val test11_4 = match (Unit, UnitP) = SOME []

val test11_5 = match (Tuple [Unit, Const(1)], TupleP [UnitP, Variable("x")]) = SOME [("x", Const(1))]

val test11_6 = match(Constructor("p1", Const(1)), ConstructorP("p1", Variable("x"))) = SOME [("x", Const(1))]

val test12 = first_match Unit [UnitP] = SOME []

val test12_1 = first_match Unit [ConstP(2), Variable("x")] = SOME [("x", Unit)]
