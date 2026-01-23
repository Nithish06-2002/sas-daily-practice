libname pg1 "/home/u64168920/EPG1V2/data";

/* print the data np_species */
proc print data=pg1.np_species;
var  Species_ID Category Scientific_Name Common_Names;
run;

/* proc freq step */
proc freq data=pg1.np_species;
where species_ID like 'YOSE%' and category = 'Mammal';
run;

proc freq data=pg1.np_species;
where Species_ID like 'ZION%' and Category='Bird';
run;
