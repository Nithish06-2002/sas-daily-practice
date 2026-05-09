/* basic_sas_datastep_proc.sas - DATA step + PROC PRINT basics */
/* Manual dataset creation, DROP/KEEP, dataset label. */

/* 1. Creating a dataset manually */
data nithi;
    length name $20 criteria $3;
    input name $ age criteria $ weight;
    datalines;
aashrith 23 yes 78
manish   29 no  85
varsha   24 yes 67
chaitha  28 yes 64
poornim  57 yes 91
;
run;

proc print data=nithi;
    title "Manual Dataset - NITHI";
run;

/* DROP and KEEP example on sashelp.class */
data nithi1;
    set sashelp.class;
    drop sex height;
    keep name age;
run;

title "Dataset after DROP and KEEP";

proc print data=nithi1;
run;

/* Adding dataset label */
data nithi1 (label="Nithi New File");
    set nithi1;
run;

proc print data=nithi1;
run;
