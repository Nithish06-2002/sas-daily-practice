title "US National Park Regional Usage Summary";

ods rtf file="/home/u64168920/ParkReport.rtf";

proc freq data=pg1.np_final;
    tables Region /nocum;
run;

proc means data=pg1.np_final mean median max nonobs maxdec=0;
    class Region;
    var DayVisits Campers;
run;

title2 'Day Visits vs. Camping';
proc sgplot data=pg1.np_final;
    vbar  Region / response=DayVisits;
    vline Region / response=Campers ;
run;
title;

ods rtf close;
