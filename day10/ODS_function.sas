/* The Output Delivery System is a powerful component of Base SAS that enhances the appearance and functionality of SAS procedure and DATA step output. 
It overcomes the limitations of traditional, monospace line-printer output by delivering results in various user-friendly formats.  */


libname pg1 "/home/u64168920/EPG1V2/data";


*Add ODS statement to export xlsx file;

ods Excel file="/home/u64168920/pressure.xlsx" style=Analysis;
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

*Add ODS statement to close the above ods function;

ods proctitle;
ods excel close;
