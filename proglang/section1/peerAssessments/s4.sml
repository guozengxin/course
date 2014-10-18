(* Compare date which one is further away in the past, just imagine that 2 guy *)
(* are born on those dates, and which one of them would be older *)

(* fun form (date: int * int * int) = (* Make a number looks like YYYYMMDD *) *)
(*     10000 * #1 date + 100 * #2 date + #3 date *)

(* fun is_older (date1: int * int * int, date2: int * int * int) = (* Compare *) *)
(*     form(date1) < form(date2) *)

fun is_older (date1: int * int * int, date2: int * int * int) =
    let fun form_string (date: int * int * int) = (* Make a number looks like YYYYMMDD *)
            10000 * #1 date + 100 * #2 date + #3 date
    in
        form_string(date1) < form_string(date2)
    end;

fun number_in_month (dates_list: (int * int * int) list, month: int) =
    if null dates_list
    then 0
    else if #2 (hd dates_list) = month
    then 1 + number_in_month( (tl dates_list), month)
    else number_in_month( (tl dates_list), month);

fun number_in_months (dates_list: (int * int * int) list, months: int list) =
    if null months
    then 0
    else (number_in_month (dates_list, hd months) +
          number_in_months (dates_list, tl months));

fun dates_in_month (dates_list: (int * int * int) list, month: int) =
    if null dates_list
    then []
    else if #2 (hd dates_list) = month
    then hd (dates_list) :: dates_in_month (tl dates_list, month)
    else dates_in_month (tl dates_list, month);

fun dates_in_months (dates_list: (int * int * int) list, months: int list) =
    let fun append (xs: (int * int * int) list, ys : (int * int * int) list) =
            if null xs
            then ys
            else (hd xs) :: append(tl xs, ys);
    in
    if null months
    then []
    else append (dates_in_month (dates_list, hd months),
                 dates_in_months(dates_list, tl months))
    end;


fun get_nth (inputs: string list, nth: int) =
    if nth = 1
    then hd (inputs)
    else get_nth (tl inputs, nth - 1) ;

val month_names = [ "January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November",
                    "December" ];

(* This is for sosml: *)
(* load "Int"; *)

fun date_to_string (date: int * int * int) =
    get_nth(month_names, #2 date) ^ " " ^
    Int.toString (#3 date) ^ ", " ^
    Int.toString (#1 date);

fun number_before_reaching_sum (sum: int, numbers: int list) =
    if sum <= 0
    then ~1
    else 1 + number_before_reaching_sum (sum - hd numbers, tl numbers);

val days_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

fun what_month (day_of_year: int) =
    1 + number_before_reaching_sum (day_of_year, days_of_month);

fun month_range (day1: int, day2: int) =
    if day2 - day1 < 0
    then []
    else what_month day1 :: month_range( day1 + 1, day2);

fun oldest (dates: (int * int * int) list) =
    if null dates
    then NONE
    else
        let
            val sub_oldest = oldest (tl dates)
        in
            if isSome (oldest(tl dates)) andalso
               is_older (valOf (oldest(tl dates)), hd dates)
            then oldest(tl dates)
            else SOME (hd dates)
        end;

(* Challenge functions *)
fun number_in_months_challenge (dates: (int * int * int) list, months: int list) =
    "";

(* fun reasonable_date *)
