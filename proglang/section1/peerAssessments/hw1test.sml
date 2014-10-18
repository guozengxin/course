(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "s4.sml";

val test1 = is_older((1,2,3),(2,3,4)) = true

val test1_1 = is_older((2000,2,3),(2000,3,4)) = true

val test1_2 = is_older((2000,2,3),(2000,2,4)) = true

val test1_3 = is_older((2000,2,3),(2000,2,3)) = false

val test1_4 = is_older((1999,3,3),(2000,3,4)) = true

val test1_5 = is_older((2001,3,3),(2000,3,4)) = false

val test1_6 = is_older((2000,3,3),(2000,2,4)) = false

val test1_7 = is_older((2000,2,4),(2000,2,3)) = false

val test2 = number_in_month([(2012,2,28),(2013,12,1)],2) = 1

val test2_1 = number_in_month([(2012,2,28),(2013,2,1)],2) = 2

val test2_2 = number_in_month([(2012,4,28),(2013,4,1)],2) = 0

val test2_3 = number_in_month([],3) = 0

val test3 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test3_1 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2]) = 1

val test3_2 = number_in_months([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2]) = 2

val test3_3 = number_in_months([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2, 4]) = 3

val test3_4 = number_in_months([],[2, 4]) = 0

val test3_5 = number_in_months([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[]) = 0

val test4 = dates_in_month([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test4_1 = dates_in_month([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]

val test4_2 = dates_in_month([(2012,2,28),(2013,2,1)],3) = []

val test4_3 = dates_in_month([],3) = []

val test4_4 = dates_in_month([(2012,2,28),(2013,12,1),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]

val test5 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test5_1 = dates_in_months([(2012,3,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,3,28),(2011,3,31),(2011,4,28)]

val test5_2 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,2,28)],[2,3,4]) = [(2012,2,28),(2011,2,28),(2011,3,31)]

val test5_3 = dates_in_months([],[2,3,4]) = []

val test5_4 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,2,28)],[]) = []

val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"

val test6_1 = get_nth(["hi", "there", "how", "are", "you"], 5) = "you"

val test6_2 = get_nth(["hi"], 1) = "hi"

val test7 = date_to_string((2013, 6, 1)) = "June 1, 2013"

val test7_1 = date_to_string((2013, 1, 20)) = "January 20, 2013"

val test8 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3

val test8_1 = number_before_reaching_sum(11, [1,2,3,4,5]) = 4

val test8_2 = number_before_reaching_sum(1, [1,2,3,4,5]) = 0

val test9 = what_month(70) = 3

val test9_1 = what_month(31) = 1

val test9_2 = what_month(365) = 12

val test10 = month_range(31, 34) = [1,2,2,2]

val test10_1 = month_range(31, 31) = [1]

val test10_2 = month_range(31, 30) = []

val test10_3 = month_range(365, 365) = [12]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

val test11_1 = oldest([]) = NONE

val test11_2 = oldest([(1,1,28),(2011,3,31),(2011,4,28)]) = SOME (1,1,28)

(*

val test12 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,4]) = 3

val test12_1 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2]) = 1

val test12_2 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2,12,12,2,4]) = 4

val test12_3 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2,4,2]) = 3

val test12_4 = number_in_months_challenge([],[2,2,4]) = 0

val test12_5 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,4]) = [(2012,2,28),(2011,4,28)]

val test12_6 = dates_in_months_challenge([(2012,3,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,4]) = [(2012,3,28),(2011,3,31),(2011,4,28)]

val test12_7 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,2,28)],[2,3,12,4,12]) = [(2012,2,28),(2011,2,28),(2011,3,31),(2013,12,1)]

val test12_8 = dates_in_months_challenge([],[2,3,4]) = []

val test12_9 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,2,28)],[]) = []

val test13 = reasonable_date((1,1,1)) = true

val test13_1 = reasonable_date((0,1,1)) = false

val test13_2 = reasonable_date((~1,1,1)) = false

val test13_3 = reasonable_date((2000,~1,1)) = false

val test13_4 = reasonable_date((2000,0,1)) = false

val test13_5 = reasonable_date((2000,1,1)) = true

val test13_6 = reasonable_date((2000,2,28)) = true

val test13_7 = reasonable_date((2000,2,29)) = true

val test13_8 = reasonable_date((2001,2,29)) = false

val test13_9 = reasonable_date((1900,2,29)) = false

val test13_10 = reasonable_date((1904,2,29)) = true

val test13_11 = reasonable_date((1904,3,~1)) = false

val test13_12 = reasonable_date((1904,3,0)) = false

val test13_13 = reasonable_date((1904,3,31)) = true

val test13_14 = reasonable_date((1904,3,32)) = false

val test13_15 = reasonable_date((1904,4,31)) = false

val test13_16 = reasonable_date((1904,4,30)) = true
*)
