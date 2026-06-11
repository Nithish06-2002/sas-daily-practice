/* Day 15 - SUM statement (accumulator) */
/* SUM statement carries running totals across rows; missing values count as zero. */

/* Inline accumulator example: TOTAL grows by AMOUNT each row, missing skipped */
DATA H;
    INPUT AMOUNT;
    TOTAL + AMOUNT;
    DATALINES;
.
10
20
30
40
50
;
RUN;

proc print data=H;
    title "SUM accumulator over inline AMOUNT";
run;

/* Same idea on sashelp.class - cumulative AGE */
DATA K;
    SET SASHELP.CLASS;
    TOTAL + AGE;
RUN;

proc print data=K;
    title "Cumulative AGE on sashelp.class";
run;
