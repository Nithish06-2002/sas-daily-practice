/* ========================= */
/* PROC PRINT Examples */
/* ========================= */

proc print data=sashelp.class;
run;

proc print data=sashelp.class;
   var _numeric_;
run;

proc print data=sashelp.class;
   var _character_;
run;

proc print data=sashelp.class;
   var Name Age Height Weight;
   sum Age Height Weight;
run;


/* ========================= */
/* PROC COMPARE */
/* ========================= */

proc compare data=sashelp.class 
             compare=sashelp.classfit;
run;


/* ========================= */
/* PROC CONTENTS */
/* ========================= */

proc contents data=sashelp.class;
run;


/* ========================= */
/* PROC SORT Examples */
/* ========================= */

/* Simple sort */
proc sort data=sashelp.class out=sorted_class;
   by Age;
run;

/* Remove duplicates (keep first occurrence) */
proc sort data=sashelp.class 
          out=nodup_class 
          dupout=duplicates 
          nodupkey;
   by Age;
run;

/* Descending sort */
proc sort data=sashelp.class out=desc_class;
   by descending Age;
run;


/* ========================= */
/* FIRST. and LAST. Processing */
/* ========================= */

/* Data must be sorted before BY processing */
proc sort data=sashelp.class out=x;
   by Age;
run;

/* First occurrence */
data first_age;
   set x;
   by Age;
   if first.Age;
run;

/* Last occurrence */
data last_age;
   set x;
   by Age;
   if last.Age;
run;

/* Unique occurrence */
data unique_age;
   set x;
   by Age;
   if first.Age and last.Age;
run;

proc print data=unique_age;
run;


/* ========================= */
/* Interleaving Example */
/* ========================= */

/* Example structure (datasets must be sorted) */
/*
proc sort data=ds1; by var; run;
proc sort data=ds2; by var; run;

data combined;
   set ds1 ds2;
   by var;
run;
*/


/* ========================= */
/* PROC TABULATE Example */
/* ========================= */

proc tabulate data=sashelp.class;
   class Sex;
   var Height;
   table Sex, Height*(n mean);
run;
