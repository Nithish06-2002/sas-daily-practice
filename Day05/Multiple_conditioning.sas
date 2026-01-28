/* Subsetting by Multiple Conditions and Creating a Sorted SAS Table */

/* creat a data file name Fox to  find out the Common_names of row one */

data Fox;
	set pg1.np_species;
	where Category EQ "Mammal" and common_names like "%Fox%" and common_names not 
		like "%squirrels%";
	drop Category Record_Status Occurrence Nativeness;
run;

/* Proc sort */
proc sort data=Fox;
	by Common_Names;
run;

/* Proc print */
proc print data=Fox;
run;
