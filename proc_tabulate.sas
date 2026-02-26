/* Create dataset */
data j;
    set sashelp.cars;
run;


/*========================*/
/* 1 DIMENSION            */
/* Only Row OR Column     */
/*========================*/

/* 1D – Row only */
proc tabulate data=j;
    class Type;
    table Type;      /* Only row */
run;

/* 1D – Column only */
proc tabulate data=j;
    class Type;
    table , Type;    /* Only column */
run;


/*========================*/
/* 2 DIMENSION            */
/* Row × Column           */
/*========================*/

/* 2D – Class × Class */
proc tabulate data=j;
    class Make Type;
    table Make , Type;   /* Row=Make  Column=Type */
run;

/* 2D – Class × Statistic */
proc tabulate data=j;
    class Type;
    var MPG_City;
    table Type , MPG_City*(mean min max); 
    /* Row=Type  Column=Statistics */
run;


/*========================*/
/* 3 DIMENSION            */
/* Page × Row × Column    */
/*========================*/

proc tabulate data=j;
    class Origin Type DriveTrain;
    table Origin , Type , DriveTrain;
    /* Page=Origin
       Row=Type
       Column=DriveTrain */
run;
