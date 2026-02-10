/* Date values with respective informats & formats */

01/12/2003    ddmmyy10.    ddmmyy10.
23-12-2003    ddmmyy10.    ddmmyyd10.
23.12.2003    ddmmyy10.    ddmmyyp10.
23:12:2003    ddmmyy10.    ddmmyyc10.
23 12 2003    ddmmyy10.    ddmmyyb10.
12dec2003     date9.       date9.
12-dec-2003   date11.      date11.
12dec03       date7.       date7.  ;

data h;
format date date9.;
input name $ date : ANYDTDTE.;
datalines;
dsd 12-02-2023
fds 21FEB2023
;
run;


DATA J;
LENGTH NITHIS $ 20;
INPUT NITHIS $ DATE;
INFORMAT DATE DDMMYY10.;
FORMAT DATE DDMMYYP10.;
CARDS;
NIHTISH 12/02/2002
VEDAMURTHY 14/04/2002
;
CLO = FORMAT DATE DATE10.;
RUN;


/* DATE FUNCTIONS */

DATA H;
D="31dec2004"d;
FORMAT D ddmmyy10.;
d1= day(d);
m1=month(d);
y1=year(d);
q=qtr(d);
w1=week(d);
RUN;


/* intck -->check the date in between the two date  */

/* general syntex */

variable = intck(interval,form,to);
































