libname pg1 "/home/u64168920/EPG1V2/data";

title "Frequency Report for Basin and Storm Month";


ods graphics on; *to turn on the graphs to analyse;
ods noproctitle; *to turn off the auto title theat have been asigned to in results;

proc freq data=pg1.storm_final order=freq nlevels;  
	tables StartDate / out= nith nocum plots=freqplot;
	format StartDate monname.;
run;

ods proctitle;
