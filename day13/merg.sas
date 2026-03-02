*Merge with by statement;
*combining the datasets horizontally,
there should be atleast one common variable;

GENERAL SYNTAX;

data dsn;
merge ds1 ds2...;
by var;
run;

data A1;
input id sal;
cards;
10 10000
20 20000
30 30000
;
run;

data A2;
input id name$;
cards;
10 ABC
20 XYZ
40 DEF
;
run

/* id   sal      name
   10   10000   ABC
   20   20000   XYZ
   30   30000   .
   40   .        DEF*/;

proc sort data =A1 out=x;
by id;
quit;

proc sort data =A2 out=y;
by id;
quit;

data d;
merge x y;
by id;
run;

proc sort data=d;
quit;

proc sort data=sashelp.class out=n;
by name;
quit;

proc sort data=sashelp.classfit out=k;
by name;
quit;

data t;
merge n k ;
by name;
run;

proc print data=t;
run;

data p;
set n k ;
by name;
run;
 proc print data=p;
quit;


*joins---> combines the obs from two or more datasets with common variable

left join,right join,inner join,full join,left outer join,right outer join,
full outer join;

 A={1,2,3,4}--->LEFT JOIN
B={3,4,5,6}---->RIGHT JOIN

FULL JOIN---->A OR B
-->{1,2,3,4,5,6}

INNER JOIN---->A AND B
--->{3,4}

LEFT OUTER JOIN----> A-B
{1,2}

RIGHT OUTER JOIN
{5,6}

FULL OUTER JOIN
{1,2,5,6}

IN---> TEMPORARY VAR--> TO READ OBSERVATION
/FULL JOIN/

data k1;
merge x(in=a) y(in=b);
by id;
if a=1 or b=1;
run;

proc print data=k1;
quit;

/INNER JOIN/;

data k2;
merge x(in=a) y(in=b);
by id;
id a=1 and b=1;
run;

proc print data=k2;
quit;

/LEFT JOIN/;

data k3;
merge x(in=a) y(in=b);
by id;
if a=1;
run;
 proc print data=k3;
quit;

/RIGHT JOIN/;

data k4;
merge x(in=a) y(in=b);
by id;
if b=1;
run;

 proc print data=k4;
quit;
