/*========================
  CREATE LAB DATA
=========================*/

DATA lab;
INPUT subjid labtest $ 8-35 aval visit;
DATALINES;
100101 Basophils                  4.67 0
100101 Basophils                  3.60 1
100101 Basophils                  2.90 2
100101 Basophils                  0.90 3
100101 Basophils                  0.67 4
100101 Bilirubin                  9.10 0
100101 Bilirubin                  7.20 1
100101 Bilirubin                  6.40 2
100102 Creatinine                 0.50 0
100102 Creatinine                18.90 1
100102 Creatinine                12.10 2
100102 Creatinine                 9.80 3
100102 Eosinophils/Leukocytes    39.20 0
100102 Eosinophils/Leukocytes    35.10 1
100102 Eosinophils/Leukocytes    31.50 2
;
RUN;


/*========================
  SORT THE DATA
=========================*/

PROC SORT DATA=lab;
BY subjid labtest visit;
RUN;


/*========================
  CREATE BASELINE VALUE
=========================*/

DATA baseline;
SET lab;
BY subjid labtest;

RETAIN base;

/* Visit=0 considered baseline */

IF FIRST.labtest THEN base=.;

IF visit=0 THEN base=aval;

/* Carry baseline forward */

baseval=base;

RUN;


/*========================
  DISPLAY RESULTS
=========================*/

PROC PRINT DATA=baseline NOOBS;
VAR subjid labtest visit aval baseval;
RUN;
