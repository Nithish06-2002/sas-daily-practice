data bp_data;
input subjid visit $ bp;
datalines;
101 BASELINE 120
101 WEEK1 125
101 WEEK2 128
102 BASELINE 118
102 WEEK1 121
102 WEEK2 124
103 BASELINE 130
103 WEEK1 132
103 WEEK2 135
;
run;


proc sort data=bp_data out=bp;
by subjid;
run;
proc transpose data=bp name=name;
id visit;
by subjid;
var bp;
run;

data lab_data;
input subjid test $ result;
datalines;
101 HGB 13
101 WBC 7000
101 PLT 250000
102 HGB 14
102 WBC 6800
102 PLT 270000
103 HGB 12
103 WBC 7200
103 PLT 260000
;
run;


proc sort data=lab_data out=lab;
by subjid;
run;
proc transpose data=lab;
by subjid;
id test;
var result;
run;


data ae_data;
input subjid aesoc $ severity $ count;
datalines;
101 CARDIAC MILD 2
101 CNS MODERATE 1
102 CARDIAC SEVERE 1
102 GI MILD 3
103 CNS MILD 2
103 GI MODERATE 1
;
run;

proc sort data=ae_data out=ae;
by subjid;
run;
proc transpose data=ae;
by subjid;
id aesoc;
var count;
run;
