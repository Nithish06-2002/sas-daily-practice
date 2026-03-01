/* Simple SAS Macro Example */

/* Load dataset */
data cars;
set sashelp.cars;
run;

/* Macro to show summary statistics */
%macro summary(var);

proc means data=cars mean min max;
var &var;
title "Summary for &var";
run;

%mend;

/* Run Macro */
%summary(MPG_City);
%summary(MPG_Highway);
