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

proc summary data=adam6 ;
by trt01a;
var age;
output out=age_1 n=_n_ mean=_mean_ std=_std_ median=_median_ min=_min_ max=_max_;
quit;

DATA age_2;
set age_1;
Meansd=put(_mean_,5.1)||"("||put(_std_,6.2)||")";
minmax=put(_min_,4.0)||","||put(_max_,4.0);
n=put(_N_,4.0);
Median=put(_median_,5.1);
drop _:;
run;

proc transpose data=age_2 out=age_3 prefix=tret;
var n Meansd median minmax;
id trt01a;
quit;

data age_4;
length newvar $ 40;
set age_3;
if _Name_="n" then newvar="        N";
else if _Name_="Meansd" then newvar="       Mean(SD)";
else if _Name_="Median" then newvar="       Median";
else if _Name_="minmax" then newvar="       Min,Max";
drop _Name_;
run;

data dummy;
length newvar $ 40;
newvar="Age(Years)";
run;

data age;
set dummy age_4 ;
order=1;
run;

/* Gender statistics */

proc freq data=adam6 noprint;
by trt01a;
table sex/out=gen_1;
run;

data gen_2;
set gen_1;
np=put(count,4.0)||"("||put(Percent,4.1)||")";
run;

proc sort data=gen_2;
by sex;
quit;

proc transpose data=gen_2 out=gen_3 (drop=_NAME_) prefix=tret;
var np;
id trt01a;
by sex;
run;

data gen_4;
length newvar $ 60;
set gen_3;
if sex=1 then newvar="          Male";
else if sex=2 then newvar="          Female";
run;

data dummy1;
length newvar $ 60;
newvar="Gender [n (%)]a";
run;


data gender;
set dummy1 gen_4;
order=2;
run;

/* Ethnicity */

proc freq data=adam6 noprint;
by trt01a;
table ETHNICITY/out=eth_1;
run;

data eth_2;
set eth_1;
np=put(count,4.0)||"("||put(Percent,4.1)||")";
run;

proc sort data=eth_2;
by ETHNICITY;
quit;

proc transpose data=eth_2 out=eth_3 (drop=_NAME_) prefix=tret;
var np;
id trt01a;
by ETHNICITY;
run;

data eth_4;
length newvar $ 60;
set eth_3;
if ETHNICITY=1 then newvar="          Hispanic or Latino";
else if ETHNICITY=2 then newvar="          Not Hispanic or Latino";
run;

data dummy2;
length newvar $ 60;
newvar="Ethnicity [n (%)]a";
run;


data Ethnicity;
set dummy2 eth_4;
order=3;
run;


/* Race */

proc freq data=adam6 noprint;
by trt01a;
table RACE/out=race_1;
run;

data race_2;
set race_1;
np=put(count,4.0)||"("||put(Percent,4.1)||")";
run;

proc sort data=race_2;
by RACE;
quit;

proc transpose data=race_2 out=race_3 (drop=_NAME_) prefix=tret;
var np;
id trt01a;
by RACE;
run;

data race_4;
length newvar $ 90;
set race_3;
if RACE=1 then newvar="          White";
else if RACE=2 then newvar="          Black or African American";
else if RACE=3 then newvar="          Asian";
else if RACE=4 then newvar="          American Indian or Alaskan Native";
else if RACE=5 then newvar="          Native Hawaiian or Other Pacific Islander";
else if RACE=6 then newvar="          Other";
run;

data dummy3;
length newvar $ 90;
newvar="Race [n (%)]a";
run;


data RACE;
set dummy3 race_4;
order=4;
run;

data final;
set age gender Ethnicity RACE;
keep newvar tret0 tret1 tret2 order;
run;

proc report data=final nowd headline headskip split="*";
column(order newvar tret1 tret0 tret2);
define order/group noprint;
define newvar /"" width=40;
define tret1/"BP3304*(N=31)";
define tret0/"Placebo*(N=29)";
define tret2/"Overall*(N=60)";

break after order/skip;

compute before _page_;
line "";
line @9 "14.1.2.1 Subject Demographics and Baseline Characteristics";
line @19 "Safety Population";
line " ";
endcomp;

compute after;
line @4 "Reference: Listing 16.2.4.1";
line @5 "Percentages are based on the number of subjects in the population.";
line @4 "Note: SD = standard deviation, Min = Minimum, Max = Maximum";
line "";
endcomp;
run;
