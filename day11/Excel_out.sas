libname pg1 "/home/u64168920/EPG1V2/data";

ods excel file="/home/u64168920/StormStats.xlsx" style=snow ;
ods noproctitle;

proc means data=pg1.storm_detail maxdec=0 median max;
    class Season;
    var Wind;
    where Basin='SP' and Season in (2014,2015,2016);
run;

proc print data=pg1.storm_detail noobs;
    where Basin='SP' and Season in (2014,2015,2016);
    by Season;
run;

ods excel close;
ods proctitle;
