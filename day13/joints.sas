/* joints */

proc sort data=sashelp.class out=x;
by name;
run;

proc sort data=sashelp.classfit out=y;
by name;
run;

/* full join */

data a;
merge x(in=a) y(in=b);
by name;
if a=1 or b=1;
run;

proc print data=a;
run;

/* inner join */

data b;
merge x(in=c) y(in=d);
by name;
if c=1 and d=1;
run;

proc print data=b;
run;

/* left join */

data c;
merge x(in=k) y(in=l);
by name;
if k=1;
run;

proc print data=c;
run;

/* right join */

data k4;
merge x(in=a) y(in=b);
by name;
if b=1;
run;

proc print data=k4;
run;

/* right outer join */

data ja;
merge x(in=o) y(in=p);
by name;
if o=0 and p=1;
run;

proc print data=ja;
run;

/* full outer join */

data gs;
merge x(in=d) y(in=f);
by name;
if d=0 or f=0;
run;

proc print data=gs;
run;




