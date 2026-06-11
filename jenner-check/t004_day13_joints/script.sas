/* Day 13 - MERGE-based "joins" pattern */
/* Demonstrates full / inner / left / right joins using IN= flags */
/* on two BY-sorted datasets. */

/* Companion dataset whose names overlap sashelp.class, so the merge */
/* has matches on both sides. */
data classfit_local;
    length Name $ 8;
    input Name $ Predict Lower Upper;
    datalines;
Amir    95.8  90.1  101.2
Bethany 105.2 99.0  110.5
Carlos  87.5  82.1  92.7
Diana   62.0  57.0  67.5
Ethan   128.0 122.0 134.5
Fiona   90.5  86.0  95.2
;
run;

proc sort data=sashelp.class out=x;
    by name;
run;

proc sort data=classfit_local out=y;
    by name;
run;

/* full join (a OR b) */
data fulljoin;
    merge x(in=a) y(in=b);
    by name;
    if a=1 or b=1;
run;

proc print data=fulljoin;
run;

/* inner join (a AND b) */
data innerjoin;
    merge x(in=c) y(in=d);
    by name;
    if c=1 and d=1;
run;

proc print data=innerjoin;
run;

/* left join (a) */
data leftjoin;
    merge x(in=k) y(in=l);
    by name;
    if k=1;
run;

proc print data=leftjoin;
run;

/* right join (b) */
data rightjoin;
    merge x(in=a) y(in=b);
    by name;
    if b=1;
run;

proc print data=rightjoin;
run;
