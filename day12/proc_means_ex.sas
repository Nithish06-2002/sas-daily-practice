/* PROC MEANS – Basic Statistics */

proc means data=sashelp.class n nmiss std mean cv mode;
var age height weight;
run;


/* PROC MEANS – Output Dataset */

proc means data=sashelp.class n nmiss std mean cv mode;
var age height weight;
output out=nithi;
run;


/* PROC MEANS – Cars Dataset Statistics */

proc means data=sashelp.cars n mean nmiss median std min max;
var MSRP Invoice;
output out=nithi;
run;


/* PROC MEANS – Class by Type */

proc means data=sashelp.cars;
class type;
var MSRP;
run;


/* PROC MEANS – Class by Make */

proc means data=sashelp.cars;
class make;
var MSRP;
run;


/* PROC MEANS – MPG by Type with Output */

proc means data=sashelp.cars;
class type;
var MPG_Highway;
output out=nithish;
run;
