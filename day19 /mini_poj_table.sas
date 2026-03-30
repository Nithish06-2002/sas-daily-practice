*
PLACEBO=O
DRUG=1
M=1
F=2;

proc import datafile="/home/u64252598/SAS/New Folder/ADSL (1).csv"
dbms=csv replace
out =adsl;
getnames=yes;
run;

data adsl_1;
set adsl;
if TRT="Placebo" THEN TRT_N=0;
ELSE IF TRT="Drug" THEN TRT_N=1;

IF SEX="M" THEN SEX_N=1;
ELSE IF SEX="F" THEN SEX_N=2;
drop TRT SEX;
RUN;

DATA ADSL2;
SET ADSL_1;OUTPUT;
TRT_N=2;OUTPUT;
RUN;

/* AGE */

PROC SORT DATA=adsl2 OUT=AGE_1 ;
BY TRT_N;
QUIT;

PROC SUMMARY DATA=AGE_1 ;
VAR AGE;
BY TRT_N;
OUTPUT OUT=AGE_2 MEAN=_MEAN_ MEDIAN=_MED_ STDDEV=_STD_ MIN=_MIN_ MAX=_MAX_;
RUN;


DATA AGE_3;
SET AGE_2;
MEANSD=STRIP(PUT(_MEAN_,5.1)||"("||PUT(_STD_,4.2)||")");
MEDIAN=STRIP(PUT(_MED_,4.2));
MINMAX=STRIP(PUT(_MIN_,4.0)||","||PUT(_MAX_,4.0));
RUN;

DATA AGE_4;
SET AGE_3;
DROP _: ;
RUN;

PROC TRANSPOSE DATA=AGE_4 out=age_5 PREFIX=TRET NAME=PARA;
VAR MEANSD MEDIAN MINMAX;
ID TRT_N;
RUN;

DATA AGE_6;
length para $ 80;
SET AGE_5;
IF PARA="MEANSD" THEN PARA="       Mean(SD)";
ELSE IF PARA="MEDIAN" THEN PARA="        Median";
ELSE IF PARA="MINMAX" THEN PARA="        Min,max";
run;

data dummy;
length para $ 80;
PARA="Age(years)";
run;

data age_final;
set dummy age_6;
order=1;
run;

/* sex */

proc sort data=ADSL2 out=sex_1;
by trt_n;
quit;

proc freq data=sex_1 noprint;
table SEX_N/out=sex_2;
by trt_n;
run;

data sex_3;
set sex_2;
male=strip(put(count,4.0)||"("||put(percent,4.1)||"%"||")");
keep TRT_N SEX_N male;
run;

data sex_4;
length NEWVAR $ 70;
set sex_3;
if SEX_N=1 THEN NEWVAR="     Male";
else if SEX_N=2 then NEWVAR="     Female";
proc sort data=ADSL2 out=sex_1;
by trt_n;
quit;

proc freq data=sex_1 noprint;
table SEX_N/out=sex_2;
by trt_n;
run;

data sex_3;
set sex_2;
male=strip(put(count,4.0)||"("||put(percent,4.1)||"%"||")");
keep TRT_N SEX_N male;
run;

data sex_4;
length PARA $ 70;
set sex_3;
if SEX_N=1 THEN PARA="     Male";
else if SEX_N=2 then PARA="     Female";
KEEP TRT_N PARA male;
run;

proc sort data=sex_4 out=sex_5 ;
by PARA trt_n;
quit;

proc transpose data=sex_5 out=sex_6 PREFIX=TRET;
by PARA;
id TRT_N;
var male;
run;


DATA DUMMY2;
length PARA $ 70;
PARA="Sex,n(%)";
run;

data final_sex;
set dummy2 sex_6;
drop _:;
order=2;
run;

data final;
set age_final final_sex;
run;

proc report data=final headline headskip;
columns (order para TRET0 TRET1 TRET2 );

define order/group noprint;
define para/ "Parameter";
define TRET0/display "Placebo(N=10)";
define TRET1/display "Drug(N=10)";
define TRET2/display "Total(N=20)";
run;


