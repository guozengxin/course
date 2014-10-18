
fun is_older(d1: (int * int * int), d2: (int * int * int)) = 
    if #1 d1 = #1 d2
    then if #2 d1 = #2 d2
       then #3 d1 < #3 d2
       else #2 d1 < #2 d2
    else #1 d1 < #2 d2


fun number_in_month(dates: (int * int * int) list, month: int) = 
    if null dates
    then 0
    else (if #2(hd dates) = month then 1 else 0) + number_in_month(tl dates, month)

fun number_in_months(dates: (int * int * int) list, months: int list) = 
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates: (int * int * int) list, month: int) = 
    if null dates
    then []
    else 
	if #2(hd dates) = month 
	then (hd dates) :: dates_in_month(tl dates, month)	
	else dates_in_month(tl dates, month)

fun dates_in_months(dates: (int * int * int) list, months: int list) = 
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(xs: string list, pos: int) = 
    if pos = 1
    then hd xs
    else get_nth(tl xs, pos - 1)

val months = ["January", "February", "March", "April",
	      "May", "June", "July", "August", "September",
	      "October", "November", "December"]

fun date_to_string(date: int * int * int) = 
    get_nth(months, #2 date) ^
    " " ^
    Int.toString(#3 date) ^
    ", " ^
    Int.toString(#1 date)


fun number_before_reaching_sum(sum: int, vals:  int list) = 
    if hd vals >= sum 
    then 0
    else 1 + number_before_reaching_sum(sum - hd vals, tl vals)

val month_lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

fun what_month(day: int) = number_before_reaching_sum(day, month_lengths) + 1

fun month_range(day1: int, day2: int) = 
    if (day1 > day2) 
    then []
    else what_month(day1) :: month_range(day1+1, day2)

fun oldest(dates: (int * int * int) list) = 
    let
	fun mindate(m: (int * int * int), dates: (int * int * int) list) = 
	    if null dates 
	    then m
	    else mindate(if is_older(m, hd dates)then m else hd dates, tl dates)
    in
	if null dates
	then NONE
	else SOME(mindate(hd dates, tl dates))
    end

fun remove_dups(xs: int list, visited: int list) = let 
    fun contains(xs: int list, v: int) =
	if null xs
	then false
	else 
	    if hd xs = v
	    then true
	    else contains(tl xs, v)
in
    if null xs
    then []
    else 
	if contains(visited, hd xs)
	then remove_dups(tl xs, visited)
	else hd xs :: remove_dups(tl xs, hd xs  :: visited)
end


fun number_in_months_challenge(dates: (int * int * int) list, months: int list) = 
    number_in_months(dates, remove_dups(months, []))

fun dates_in_months_challenge(dates: (int * int * int) list, months: int list) = 
    dates_in_months(dates, remove_dups(months, []))

fun get_nthi(xs: int list, pos: int) = 
    if pos = 1
    then hd xs
    else get_nthi(tl xs, pos - 1)

fun reasonable_date(date: (int * int * int)) = let
    val y = #1(date)
    fun divi(a: int, b: int) = a mod b = 0
    val is_leap = divi(y, 400) orelse (divi(y, 4) andalso not(divi(y, 100)))
    fun m() = if #2 date = 2 andalso is_leap then 29 else get_nthi(month_lengths, #2 date)
in
    (#1 date > 0) andalso (#2 date > 0) andalso (#2 date <13) andalso (#3 date > 0) andalso (#3 date <= m())
end
