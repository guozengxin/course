(* problem 1*)
fun is_older(d1: (int * int * int), d2: (int * int * int)) = 
  if #1 d1 < #1 d2 then true
  else if #1 d1 > #1 d2 then false
  else if #2 d1 < #2 d2 then true
  else if #2 d1 > #2 d2 then false
  else if #3 d1 < #3 d2 then true
  else false
 
(* problem 2*)
fun number_in_month(dates: (int * int * int) list, month: int) =
  if null dates then 0
  else if (#2 (hd dates)) = month then
    1 + number_in_month(tl dates, month)
  else
    0 + number_in_month(tl dates, month)

(* problem 3*)
fun number_in_months(dates: (int * int * int) list, months: int list) =
  if null months then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* problem 4*)
fun dates_in_month(dates: (int * int * int) list, month: int) =
  if null dates then []
  else if (#2 (hd dates)) = month then
    (hd dates)::dates_in_month(tl dates, month)
  else
    dates_in_month(tl dates, month)

(* problem 5*)
fun dates_in_months(dates: (int * int * int) list, months: int list) =
  if null months then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* problem 6*)
fun get_nth(slist: string list, n: int) =
  if n = 1 then hd slist
  else get_nth(tl slist, n-1)

(* problem 7*)
fun date_to_string(date: (int * int * int)) =
  let
    val monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  in
    get_nth(monthList, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

(* problem 8*)
fun number_before_reaching_sum(sum: int, iList: int list) =
  if (sum - (hd iList)) <= 0 then 0
  else 1 + number_before_reaching_sum(sum - (hd iList), tl iList)

(* problem 9*)
fun what_month(day: int) =
  let
    val daycount = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  in
    1 + number_before_reaching_sum(day, daycount)
  end

(* problem 10*)
fun month_range(day1: int, day2: int) = 
  if day1 > day2 then []
  else what_month(day1)::month_range(day1+1, day2)

(* problem 11*)
fun oldest(dates: (int * int * int) list) =
  if null dates then NONE
  else
    let val tl_oldest = oldest(tl dates)
    in
      if isSome tl_oldest andalso is_older(valOf tl_oldest, hd dates)
      then tl_oldest
      else SOME(hd dates)
    end

fun member_in_list(iList: int list, i: int) =
  if null iList then false
  else if hd iList = i then true
  else member_in_list(tl iList, i)

fun filter_same_member(iList: int list) =
  if null iList then []
  else if member_in_list(tl iList, hd iList)
  then filter_same_member(tl iList)
  else hd iList::filter_same_member(tl iList)

(* problem 12*)
fun number_in_months_challenge(dates: (int * int * int) list, months: int list) =
  number_in_months(dates, filter_same_member(months))

(* problem 12 *)
fun dates_in_months_challenge(dates: (int * int * int) list, months: int list) =
  dates_in_months(dates, filter_same_member(months))

(* problem 13 *)
fun reasonable_date(date: (int * int * int)) =
  let 
    fun is_leap_year(year: int) =
      if year mod 400 = 0 
      then true
      else if year mod 4 = 0 andalso year mod 100 <> 0
      then true
      else false

    fun day_count_of_month(year: int, month: int) =
      if month = 2 then
        if is_leap_year(year) then 29
        else 28
      else if number_in_months([(year, month, 1)], [1,3,5,7,8,10,12]) > 0
      then 31
      else 30
  in
    if #1 date <= 0 then false
    else if #2 date < 1 orelse #2 date > 12 then false
    else if #3 date < 1 orelse #3 date > day_count_of_month(#1 date, #2 date)
    then false
    else true
  end
