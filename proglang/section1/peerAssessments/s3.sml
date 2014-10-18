fun is_older(d1 : (int * int * int), d2 : (int * int * int)) = 
    (#1 d2 > #1 d1) 
    orelse 
    (#1 d2 = #1 d1) andalso (#2 d2 > #2 d1) 
    orelse 
    (#2 d2 = #2 d1) andalso (#3 d2 > #3 d1); 

fun date_in_month(date : (int * int * int), month : int) = 
    #2 date = month;

fun number_in_month(dates : (int * int * int) list, month : int) = 
    if dates = []
    then 0
    else if date_in_month (hd dates, month)
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

fun number_in_months(dates : (int * int * int) list, months : int list) = 
    if months = []
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months);

fun dates_in_month(dates : (int * int * int) list, month : int) = 
    if dates = []
    then []
    else if date_in_month(hd dates, month)
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month);

fun dates_in_months(dates : (int * int * int) list, months : int list) = 
    if months = []
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(xs : string list, position : int) = 
    if position = 1
    then hd xs
    else get_nth(tl xs, position - 1)
		
fun date_to_string(date : (int * int * int)) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] 
	val month = get_nth(months, #2 date)
	val year = Int.toString (#1 date)
	val day = Int.toString (#3 date) 
    in
	month ^ " " ^ day ^ ", " ^ year
    end

fun number_before_reaching_sum(number : int, numbers : int list) = 
    let fun count(items : int list) = 
	    if items = []
	    then 0
	    else 1 + count (tl items)
	fun numbers_after_reaching_sum(number : int, numbers : int list) = 
	    if number <= hd numbers
	    then numbers
	    else numbers_after_reaching_sum(number - hd numbers, tl numbers)
    in 
	count(numbers) - count (numbers_after_reaching_sum(number, numbers))
    end

fun what_month(days : int) = 
    let val monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(days, monthDays) + 1
    end

fun month_range(from : int, to : int) = 
    if from > to
    then []
    else if from = to
    then [what_month(from)]
    else what_month(from) :: month_range(from + 1, to)

fun older(d1 : (int * int * int), d2 : (int * int * int)) = 
    if is_older(d1, d2)
    then SOME d1
    else if is_older(d2, d1)
    then SOME d2
    else NONE 

fun oldest(dates : (int * int * int) list) = 

    let fun count(items : (int * int * int) list) = 
	    if items = []
	    then 0
	    else 1 + count (tl items)

	fun older(a : (int * int * int), b : (int * int * int)) = 
	    if is_older(a, b)
	    then a
	    else b

	fun oldest_non_empty(dates : (int * int * int) list) =
	    if count(dates) = 1
	    then hd dates
	    else if count(dates) = 2
	    then older(hd dates, hd (tl dates))
	    else older(hd dates, oldest_non_empty(tl dates))  
    in    
	if dates = []
	then NONE
	else SOME(oldest_non_empty dates)
    end


fun number_in_months_challenge(dates : (int * int * int) list, months : int list) = 
    let fun count(xs : int list, x : int) =
	    if xs = []
	    then 0
	    else 
		let val increment = if hd xs = x then 1 else 0
		in
		    increment + count (tl xs, x)
		end
		    
	fun remove_duplicates(xs : int list) = 
	    if xs = []
	    then []
	    else if count(xs, hd xs) > 1
	    then remove_duplicates(tl xs)
	    else hd xs :: remove_duplicates(tl xs)
    in
	number_in_months(dates, remove_duplicates(months))
    end


fun dates_in_months_challenge(dates : (int * int * int) list, months : int list) = 
    let fun count(xs : (int * int * int) list, x : (int * int * int)) =
	    if xs = []
	    then 0
	    else 
		let val increment = if hd xs = x then 1 else 0
		in
		    increment + count (tl xs, x)
		end
		    
	fun remove_duplicates(xs : (int * int * int) list) = 
	    if xs = []
	    then []
	    else if count(xs, hd xs) > 1
	    then remove_duplicates(tl xs)
	    else hd xs :: remove_duplicates(tl xs)
    in
	dates_in_months(remove_duplicates(dates), months)
    end

fun reasonable_date(date : (int * int * int)) = 
    let val year = #1 date
	val month = #2 date
	val day = #3 date
	fun get_days_in_month() = 
	    let fun get_nth(xs : int list, position : int) = 
		    if position = 1
		    then hd xs
		    else get_nth(tl xs, position - 1)
		val monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		fun leap_year () = 
		    year mod 100 <> 0 andalso year mod 4 = 0 
		    orelse year mod 400 = 0
	    in	
		if leap_year() andalso month = 2
		then 29
		else get_nth(monthDays, month)
	    end
	fun reasonable_year() = year >= 0
	fun reasonable_month() = month >= 1 andalso month <= 12
	fun reasonable_day() = day >= 1 andalso day <= get_days_in_month()
    in
	reasonable_year() andalso reasonable_month() andalso reasonable_day()
    end
