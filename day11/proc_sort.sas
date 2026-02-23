/* proc print */
/* proc contents */
/* proc compare */




/* proc print */
proc print data=sashelp.class;
where age > 13;
var Name Age Height Weight;
sum Age Height Weight;
run;


/* proc compare */
proc compare base=sashelp.citiday compare=sashelp.citimon;
run;



/* proc contents */
proc contents data=sashelp.class;
run;


/* general syntax */

proc sort data=dsn dupout=dsn options;
by varlist;
quit;

/* example */

libname pg1 "/home/u64168920/EPG1V2/data";

proc sort data=pg1.emp out=k;
by descending empid;
quit;


/* example of nodupkey */

proc sort data=pg1.emp out=x dupout=y nodupkey;
by empid;
quit;

/* example of nodup */

proc sort data=pg1.emp out=a dupout=b nodup;
by empid;
quit;


/* print procedure */
proc print data=a;
quit;

/* general syntax */

data dsn;
set ds1 ds2...;
run;

data w;
set sashelp.cars sashelp.baseball;
run;

data t;
set sashelp.class sashelp.classfit;
run;

























