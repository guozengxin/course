(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2provided.sml";

val test1 = all_except_option("string", ["string"]) = SOME []

val test1_1 = all_except_option("string", ["string", "abc"]) = SOME ["abc"]

val test1_2 = all_except_option("my", ["string", "abc"]) = NONE

val test1_3 = all_except_option("string", ["ok", "string", "abc"]) = SOME ["ok", "abc"]

val test1_4 = all_except_option("string", ["ok", "string"]) = SOME ["ok"]

val test1_5 = all_except_option("string", ["ok", "my", "string"]) = SOME ["ok", "my"]

val test1_6 = all_except_option("string", ["string", "abc", "ok"]) = SOME ["abc", "ok"]

val test2 = get_substitutions1([["foo"],["there"]], "foo") = []

val test2_1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]

val test2_2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")= ["Jeffrey","Geoff","Jeffrey"]

val test2_3 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff123")= []

val test2_4 = get_substitutions1([], "Jeff123")= []

val test3 = get_substitutions2([["foo"],["there"]], "foo") = []

val test3_1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]

val test3_2 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")= ["Jeffrey","Geoff","Jeffrey"]

val test3_3 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff123")= []

val test3_4 = get_substitutions2([], "Jeff123")= []

val test4 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test4_1 = similar_names([], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"}]

val test4_2 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Freddie", middle="W", last="Smith"}) =
        [{first="Freddie", middle="W", last="Smith"}, {first="Fred", last="Smith", middle="W"}, {first="F", middle="W", last="Smith"}]

val test4_3 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Freddie123", middle="W", last="Smith"}) =
        [{first="Freddie123", middle="W", last="Smith"}]


val test5 = card_color((Clubs, Num 2)) = Black

val test5_1 = card_color((Diamonds, Jack)) = Red

val test5_2 = card_color((Spades, Ace)) = Black

val test5_3 = card_color((Hearts, Num 2)) = Red

val test6 = card_value((Clubs, Num 2)) = 2

val test6_1 = card_value((Clubs, Jack)) = 10

val test6_2 = card_value((Clubs, Queen)) = 10

val test6_3 = card_value((Clubs, King)) = 10

val test6_4 = card_value((Clubs, Ace)) = 11

val test7 = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test7_1 = remove_card([(Hearts, Ace), (Clubs, Num 2)], (Hearts, Ace), IllegalMove) = [(Clubs, Num 2)]

(* val test7_2 = remove_card([(Hearts, Jack), (Clubs, Num 2)], (Hearts, Ace), IllegalMove) = [(Hearts, Jack), (Clubs, Num 2)] *)

val test7_3 = remove_card([(Hearts, Ace), (Clubs, Num 2), (Hearts, Ace), (Spades, Queen)], (Hearts, Ace), IllegalMove) = 
                [(Clubs, Num 2),(Hearts, Ace), (Spades, Queen)]

val test7_4 = remove_card([(Clubs, Num 2), (Hearts, Ace), (Spades, Queen)], (Hearts, Ace), IllegalMove) = 
                [(Clubs, Num 2),(Spades, Queen)]

val test7_5 = remove_card([(Hearts, Num 2), (Hearts, Ace), (Spades, Queen), (Hearts, Num 2)], (Hearts, Num 2), IllegalMove) = 
                [(Hearts, Ace), (Spades, Queen), (Hearts, Num 2)]

val test7_6 = remove_card([(Clubs, Num 2), (Hearts, Ace), (Spades, Queen), (Hearts, Num 2)], (Spades, Queen), IllegalMove) = 
                [(Clubs, Num 2), (Hearts, Ace),(Hearts, Num 2)]

val test8 = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true

val test8_1 = all_same_color([]) = true

val test8_2 = all_same_color([(Hearts, Ace)]) = true

val test8_3 = all_same_color([(Hearts, Ace), (Diamonds, Jack)]) = true

val test8_4 = all_same_color([(Hearts, Ace), (Clubs, Jack)]) = false

val test8_5 = all_same_color([(Hearts, Ace), (Clubs, Jack), (Spades, Num 2), (Clubs, Queen)]) = false

val test9 = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4

val test9_1 = sum_cards([(Clubs, Num 8),(Clubs, Num 2)]) = 10

val test9_2 = sum_cards([(Clubs, Jack),(Clubs, Num 2)]) = 12

val test9_3 = sum_cards([(Clubs, Jack),(Clubs, Num 2),(Clubs, Ace)]) = 23

val test9_4 = sum_cards([]) = 0

val test10 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test10_1 = score([(Hearts, Num 2),(Clubs, Num 4),(Clubs, Ace)],10) = 21

val test10_2 = score([(Hearts, Num 2),(Diamonds, Num 4),(Hearts, Ace)],10) = 10

val test10_3 = score([(Hearts, Num 6),(Diamonds, Num 4),(Hearts, Ace)],21) = 0

val test10_4 = score([],2) = 1

val test11 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test11_1 = officiate([],[Draw], 15) = 7

val test11_2 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Discard (Hearts, Num 2)], 15) = 7

val test11_3 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw, Discard (Clubs, Num 4)], 15) = 6

val test11_4 = officiate([(Hearts, Num 9),(Clubs, Ace),(Spades, Jack)],[Draw, Draw, Draw], 15) = 15

val test11_5 = officiate([(Hearts, Num 9),(Diamonds, Ace),(Spades, Jack)],[Draw, Draw, Draw], 15) = 7

val test11_6 = officiate([(Hearts, Num 9),(Diamonds, Ace),(Spades, Jack)],[], 15) = 7

val test11_7 = officiate([(Hearts, Num 9),(Diamonds, Num 2),(Spades, Jack)],[Draw, Draw, Draw, Discard (Diamonds, Num 2)], 15) = 18

val test11_8 = officiate([(Hearts, Num 9),(Diamonds, Num 2),(Hearts, Jack)],[Draw, Draw, Draw, Discard (Diamonds, Num 2)], 15) = 9

val test11_9 = officiate([(Hearts, Num 9),(Diamonds, Num 2),(Hearts, Num 1)],[Draw, Draw, Draw, Discard (Diamonds, Num 2)], 15) = 2

val test11_10 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3

val test11_11 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
val test12 = score_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 42) = 3

val test12_1 = score_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 40) = 3

val test13 = officiate_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3

val test13_1 = officiate_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       40)
             = 3

val test13_2 = ((officiate_challenge([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         40);
               false) 
              handle IllegalMove => true)
