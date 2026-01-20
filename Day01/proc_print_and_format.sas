/* 
Day 01 – PROC PRINT and FORMAT statement
Purpose: Basic data inspection and formatting
Data Source: SAS Coursera practice dataset
*/

libname pg1 "/home/u64168920/EPG1V2/data";

proc print data=pg1.storm_summary(obs=10);
    format StartDate EndDate date11.;
run;
