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
