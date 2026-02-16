ods rtf file="/home/u64168920/pressur.rtf"  STARTPAGE=NO;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods rtf close;
