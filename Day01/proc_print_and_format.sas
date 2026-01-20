/* 
Day 01 – PROC PRINT and PROC FREQ with FORMAT statement
Purpose: Basic data inspection and month-wise frequency analysis
Data Source: SAS Coursera practice dataset
*/

libname pg1 "/home/u64168920/EPG1V2/data";

/* Basic data inspection */
proc print data=pg1.storm_summary(obs=10);
    format StartDate EndDate date11.;
run;

/* Month-wise frequency of StartDate */
proc freq data=pg1.storm_summary order=freq;
    tables StartDate;
    format StartDate monname.;
run;
