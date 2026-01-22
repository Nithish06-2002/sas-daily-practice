/* proc sort data (np_summary) */
proc sort data=PG1.np_summary out=NP_SORT;
    where Type = "NP";
    by REG descending DayVisits;
run;
