***************************************************************************************
*********************************SUM STATMENT******************************************
***************************************************************************************

1.CARRY FORWARDING LAST OBSERVATIOON VALUE  TO CURRENT OBSERVAATION VALUE
2.MISSING VALUES TREATS AS ZERO
  ACCUMULATION VARIABLES (PERFORMS SERIES OF CALCULATION)
3.ACCUMULATION VARIABLES STARTS FORM ZERO FOR MISSING VALUE AAAT COMPILIONS;

DATA H;
INPUT AMOUNT;
TOTAL+AMOUNT;
DATALINES;
.
10
20
30
40
50
;
RUN;

/* EXAMPLE */
DATA K;
SET SASHELP.CLASS;
TOTAL+AGE;
RUN;
