data all_functions;
set sashelp.cars;

/* ========================= */
/* Character Functions       */
/* ========================= */

make_up     = upcase(make);
make_low    = lowcase(make);
make_prop   = propcase(make);

len_make    = length(make);

combine1    = cat(make,type);
combine2    = catx("@",make,type);
combine3    = make || "-" || type;

remove_space = compress(make);
single_space = compbl(make);
strip_make   = strip(make);
trim_make    = trim(make);

replace_char = translate(make,"X","A");
replace_word = tranwrd(make,"Ford","FORD");

substr_ex    = substr(make,1,3);
scan_ex      = scan(make,1);
index_ex     = index(make,"A");
indexc_ex    = indexc(make,"AEIOU");
indexw_ex    = indexw(make,"BMW");

/* ========================= */
/* Numeric Functions         */
/* ========================= */

min_price    = min(msrp,invoice);
max_price    = max(msrp,invoice);
mean_price   = mean(msrp,invoice);
sum_price    = sum(msrp,invoice);

mod_ex       = mod(msrp,1000);
range_ex     = range(msrp,invoice);

int_ex       = int(msrp);
ceil_ex      = ceil(msrp);
floor_ex     = floor(msrp);

fact_ex      = fact(5);

/* ========================= */
/* Date Functions            */
/* ========================= */

today_date   = today();
day_ex       = day(today_date);
month_ex     = month(today_date);
year_ex      = year(today_date);
qtr_ex       = qtr(today_date);
week_ex      = week(today_date);

future_date  = intnx("month",today_date,3);
months_diff  = intck("month","01JAN2024"d,today_date);

format today_date future_date date9.;

/* ========================= */
/* Automatic Variables       */
/* ========================= */

row_number = _N_;
error_flag = _ERROR_;

run;
