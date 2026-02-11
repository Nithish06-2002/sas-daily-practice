/* Sort Category 5 storms */

proc sort data=pg1.storm_final 
          out=storm_sort;
    /* Filter Category 5 storms */
    where MaxWindMPH > 156;
    /* Sort order */
    by BasinName 
       descending MaxWindMPH;

run;


/* Print report */

title "Category 5 Storms";

proc print data=storm_sort;
    /* Columns to display */
    var Season 
        Name 
        MaxWindMPH 
        MinPressure 
        StartDate 
        StormLength;
    /* Grouping */
    by BasinName;
    /* Column labels */
    label
        MaxWindMPH = "Max Wind (MPH)"
        MinPressure = "Min Pressure"
        StartDate   = "Start Date"
        StormLength = "Length of Storm (days)";
run;

title;   /* Clears title */


/* label */
data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon";
run;

/* proc mean */
proc means data=cars_update min mean max;
    var MSRP Invoice;
run;


/* proc print */
proc print data=cars_update;
    var Make Model MSRP Invoice AvgMPG;
run;
