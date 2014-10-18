val MONTH_OF_DAYS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] (* days each month, except the leap years *)
val DAYS_PER_YEARS = 365
val MONTH_NAME = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
val MONTH = 30
(*
fun days (x : (int * int * int)) int =
	let 
		fun days_passing(month : int) = 
			if month = 0
			then 0
			else List.nth(MONTH_OF_DAYS, month - 1) + days_passing(month - 1)
	in
		(#1 x * DAYS_PER_YEARS) + (#3 x) + days_passing(#2 x - 1) 	
	end
*)


(* 1 *)
fun is_older (x: (int * int * int), y: (int * int * int)) =
	let 
		fun days (element : (int * int * int)) = #1 element * DAYS_PER_YEARS + (#2 element - 1) * MONTH + #3 element
	in
		Int.<(days(x), days(y))
	end

fun number_in_month (x : (int * int * int) list, month : int) =
	if null x
	then 0
	else
		let val count = number_in_month(tl x, month)
		in
			if #2 (hd x) = month
			then count + 1
			else count
		end


fun number_in_months(x: (int * int * int) list, months : int list) = 
	if null x orelse null months
	then 0
	else
		number_in_month(x, hd months) + number_in_months(x, tl months)

fun dates_in_month(x: (int * int * int) list, month: int) = 
	if null x
	then []
	else if #2 (hd x) = month
	then hd x::dates_in_month(tl x, month)
	else dates_in_month(tl x, month)

(* 5 *)
fun dates_in_months(x: (int * int * int) list, months: int list) = 
	if null x orelse null months
	then []
	else dates_in_month(x, hd months) @ dates_in_months(x, tl months)

(* 6 *)
fun get_nth(instance: string list, nth: int) =
	if nth = 1
	then hd instance
	else get_nth(tl instance, nth - 1)

(* 7 *)
fun date_to_string(date: (int * int * int) ) = 
	let
		val month = get_nth(MONTH_NAME, #2 date)
	in
		month ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
	end

(* 8 *)
fun number_before_reaching_sum(sum: int, x: int list) = 
	if null x 
	then 0
	else
		if Int.>(hd x, sum) orelse hd x = sum
		then 0
		else 1 + number_before_reaching_sum(sum - (hd x), tl x)

(* 9 *)
fun what_month(day: int) = 
	let
		val month = number_before_reaching_sum(day, MONTH_OF_DAYS)
	in
		month + 1
	end

(* 10 *)
fun month_range(x1: int, x2: int) = 
	if Int.>(x1, x2)
	then []
	else if Int.<(x1, x2) 
	then what_month(x1)::month_range(x1 + 1, x2)
	else [what_month(x2)]

(* 11 *)
fun oldest(dates: (int * int * int) list) =
	if null dates
	then NONE
	else if length dates = 1
	then SOME (hd dates)
	else
		let
			val tmp = valOf (oldest(tl dates))
		in
			if is_older(hd dates, tmp)
			then SOME (hd dates)
			else SOME tmp
		end
