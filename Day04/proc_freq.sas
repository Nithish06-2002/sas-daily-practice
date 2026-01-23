libname pg1 "/home/u64168920/EPG1V2/data";

/* Print selected columns to verify data */
proc print data=pg1.np_species;
    var Species_ID Category Scientific_Name Common_Names;
run;

/* PROC FREQ: Mammal species in YOSE */
proc freq data=pg1.np_species;
    where Species_ID like 'YOSE%' and Category = 'Mammal';
    tables Common_Names / nocum nopercent;
run;

/* PROC FREQ: Bird species in ZION */
proc freq data=pg1.np_species;
    where Species_ID like 'ZION%' and Category = 'Bird';
    tables Common_Names / nocum nopercent;
run;
