/*SEX*
MALE=1 , FEMALE=2 

*TRTO1A*
BP3304 = 1
PLACEBO = 0

*RACE*
WHITE = 1
Black or African American =2
Asian = 3
American Indian or Alaska Native =4
Native Hawaiian or Other Pacific Islander = 5
Other = 6

*ETHNICITY*
Hispanic or Latino = 1
Not Hispanic or Latino = 2

*ALCOHOL_HISTORY*
Currently Consumes =1
Previously Consumed =2
Never Consumed =3

*TOBACCO_HISTORY*
Currently Consumes =1
Previously Consumed =2
Never Consumed =3

*/

libname Table "/home/u64252598/SAS/New Folder";
run;

PROC IMPORT DATAFILE="/home/u64252598/SAS/New Folder/ADSL.xlsx"
OUT=table.ADAM
DBMS=XLSX REPLACE;
GETNAMES=YES;
QUIT;

data k;
set table.adam;
run;

proc contents data=k;
quit;

proc means data=k maxdec=0;
quit;


proc sort data=k out=adam1;
by age;
quit;

data adam4;
set adam1;
if sex="Male" then sex=1;
else if sex="Female" then sex=2;
if TRT01A="BP3304" THEN TRT01A=1;
ELSE IF TRT01A="Placebo" THEN TRT01A=0;
IF RACE="Asian" THEN RACE=3;
IF RACE="White" THEN RACE=1;
IF RACE="American Indian or Alaska Native" THEN RACE=4;
IF RACE="Native Hawaiian or Other Pacific Islander" THEN RACE=5;
IF RACE="Black or African American" THEN RACE=2;
IF RACE="Other" THEN RACE=6;
IF ETHNICITY = "Hispanic or Latino" THEN ETHNICITY=1;
IF ETHNICITY = "Not Hispanic or Latino" THEN ETHNICITY=2;
IF ALCOHOL_HISTORY = "Currently Consumes" THEN ALCOHOL_HISTORY =1;
IF ALCOHOL_HISTORY = "Previously Consumed" THEN ALCOHOL_HISTORY =2;
IF ALCOHOL_HISTORY ="Never Consumed" THEN ALCOHOL_HISTORY =3;
IF TOBACCO_HISTORY ="Currently Consumes" THEN TOBACCO_HISTORY=1;
IF TOBACCO_HISTORY ="Previously Consumed" THEN TOBACCO_HISTORY=2;
IF TOBACCO_HISTORY = "Never Consumed" THEN TOBACCO_HISTORY=3;
run;

data adam5;
set adam4;output;
TRT01A=2;output;
run;

proc sort data=adam5 out=adam6;by TRT01A;
quit;

proc summary data=adam6 print;
by trt01a;
var age;
output out=age_1 n=_n_ mean=_mean_ median=_median_ min=_min_ max=_max_;
quit;
