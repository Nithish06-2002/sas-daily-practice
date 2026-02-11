title "Storm Analysis";

proc means data=pg1.storm_final;
	var MaxWindMPH MinPressure;
run;

title2 "Frequency Report for Basin";

proc freq data=pg1.storm_final;
	tables BasinName;
run;
