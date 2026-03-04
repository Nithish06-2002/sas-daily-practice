/* proc tabularte */
proc tabulate data=n;
class basin type;
var MaxwindMPH;
table basin='Ocean Basin',
      type='Storm Type'*MaxwindMPH*(mean max min);
format MaxwindMPH 8.2;
title "Storm Wind Speed Summary";
run;

/* proc tabulate advance */
proc tabulate data=n;
class basin type;
var MaxwindMPH;
table basin='Basin',
      type='Storm Type',
      MaxwindMPH*(mean='Average Wind'
                  max='Maximum Wind'
                  min='Minimum Wind');

run;
