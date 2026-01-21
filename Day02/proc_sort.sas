libname pg1 "/home/u64168920/EPG1V2/data";

proc sort data=pg1.storm_summary out=storm_sort;
    where Basin in ('NA','na');
    by descending MaxWindMPH;
run;
