/* Day 20 - FIRST.var and LAST.var BY-group processing */
/* On sashelp.class sorted by Age. */

Proc sort data=SAShelp.class out=sclass;
    By Age;
run;

Proc print data=sclass;
run;

/* First occurrence */
Data Sclass1;
    set Sclass;
    By Age;
    If first.age=1;
Run;

Proc Print data=sclass1;
Run;

/* Last occurrence */
Data Sclass2;
    set Sclass;
    By age;
    If last.age=1;
Run;

Proc Print data=sclass2;
Run;

/* Unique occurrence */
Data Sclass3;
    set Sclass;
    By age;
    If First.age=1 and last.age=1;
Run;

Proc Print data=sclass3;
Run;
