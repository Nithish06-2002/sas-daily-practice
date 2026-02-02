/* proc import csv file */
proc import datafile="/home/u64168920/EPG1V2/data/np_traffic.csv"
    out=nithi
    dbms=csv
    replace;
    delimiter=',';
    getnames=yes;
run;

/* check dataset structure */
proc contents data=nithi;
run;

/* create dataset using cards */
data nithi2;
    input a 1-4 b $ 5-24 c $ 25-32;
    cards;
8088 dfukdjewf@gmail.com wfuoew
2384 ewihfwefe@gmail.com ewfbud
3489 weufhiief@gmail.com whfdc
4893 wefbu@gmail.com     oufe9w
3294 efuifwoif@gmail.com wohfu
;
run;

/* filename reference for excel */
filename nithi3 "/home/u64168920/EPG1V2/data/eu_sport_trade.xlsx";

/* import excel file */
proc import datafile=nithi3
    out=nithi_excel
    dbms=xlsx
    replace;
    getnames=yes;
run;

/* example: infile with delimiter */
/*
data nithi_delim;
    infile "/home/u64168920/EPG1V2/data/sample.txt" dlm='$' dsd;
    input var1 $ var2 $ var3 $;
run;
*/

/* example: missover usage */
/*
data nithi_miss;
    infile "/home/u64168920/EPG1V2/data/sample2.txt" missover;
    input number : 5.;
run;
*/
