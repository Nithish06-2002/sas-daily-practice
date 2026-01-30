/*========================================================
  File Name : basic_sas_datastep_proc.sas
  Purpose   : Practice of SAS DATA step and PROC statements
  Author    : Nithi
========================================================*/

/*-------------------------------
  1. Creating a dataset manually
--------------------------------*/
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


/*-------------------------------
  2. Importing CSV file
--------------------------------*/
proc import datafile="/home/u64168920/EPG1V2/data/np_traffic.csv"
    out=newcsv
    dbms=csv
    replace;
    getnames=yes;
run;


/*-------------------------------
  3. DROP and KEEP example
--------------------------------*/
data nithi1;
    set sashelp.class;

    /* DROP removes variables */
    drop sex height;

    /* KEEP retains only mentioned variables */
    keep name age;
run;

title "Dataset after DROP and KEEP";

proc print data=nithi1;
run;


/*-------------------------------
  4. Adding dataset label
--------------------------------*/
data nithi1 (label="Nithi New File");
    set nithi1;
run;

proc print data=nithi1;
run;


/*-------------------------------
  5. Display only character variables
--------------------------------*/
proc print data=nithi1;
    var _character_;
    title "Character Variables Only";
run;


/*-------------------------------
  6. Display only numeric variables
--------------------------------*/
proc print data=nithi1;
    var _numeric_;
    title "Numeric Variables Only";
run;
