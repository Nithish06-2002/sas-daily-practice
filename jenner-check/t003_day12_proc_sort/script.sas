/* Day 12 - PROC PRINT, PROC CONTENTS, PROC SORT, FIRST./LAST., PROC TABULATE */
/* All examples use sashelp.class. */

/* PROC PRINT examples */
proc print data=sashelp.class;
run;

proc print data=sashelp.class;
   var Name Age Height Weight;
   sum Age Height Weight;
run;

/* PROC CONTENTS */
proc contents data=sashelp.class;
run;

/* PROC SORT - simple */
proc sort data=sashelp.class out=sorted_class;
   by Age;
run;

/* PROC SORT - remove duplicates */
proc sort data=sashelp.class
          out=nodup_class
          dupout=duplicates
          nodupkey;
   by Age;
run;

/* PROC SORT - descending */
proc sort data=sashelp.class out=desc_class;
   by descending Age;
run;

/* FIRST. and LAST. processing */
proc sort data=sashelp.class out=x;
   by Age;
run;

data first_age;
   set x;
   by Age;
   if first.Age;
run;

data last_age;
   set x;
   by Age;
   if last.Age;
run;

data unique_age;
   set x;
   by Age;
   if first.Age and last.Age;
run;

proc print data=unique_age;
run;

/* PROC TABULATE - height stats by sex */
proc tabulate data=sashelp.class;
   class Sex;
   var Height;
   table Sex, Height*(n mean);
run;
