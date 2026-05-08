/* Base Line Dataset */

DATA Lab;

    INPUT 
        subjid 
        labtest $ 8-29 
        aval 
        visit
    ;

DATALINES;

100101 Basophils              4.67 0
100101 Basophils              3.6  1
100101 Basophils              2.9  2
100101 Basophils              0.9  3
100101 Basophils              0.67 4
100101 Bilirubin              9.1  0
100101 Casts granular(urine)  4.2  0
100101 Casts granular(urine)  1.9  1
100101 Casts granular(urine)  2.3  3
100102 Casts granular(urine)  0    4
100102 Casts granular(urine)  0.4  1
100102 Creatinine             0.5  0
100102 Creatinine             18.9 1
100102 Creatinine             12.1 2
100102 Eosinophils/Leukocytes 39.2 0
;

RUN;


/* View Dataset */

PROC PRINT DATA=Lab;
RUN;

DATA LAB1;
SET Lab;
IF VISIT=1 THEN DO;
BLFL="Y";
END;
RUN;
PROC PRINT DATA=LAB1;
RUN;

DATA LAB2;
SET LAB1;
RETAIN BASE;
IF BLFL = "Y" THEN DO;
BASE = aval;
END;
RUN;
PROC PRINT DATA=LAB2;
RUN;

DATA LAB3;
SET LAB2;
IF visit = 0 THEN DO;
BASE = ".";
END;
RUN;
PROC PRINT DATA=LAB3;
RUN;

/* CALCULATE THE PERCENT CHANGE */
CHG = AVSL-BASE;

DATA BASELINE;
SET LAB3;
IF BLFL ^= "Y" THEN DO;
CHG=aval-BASE;
PCHG=ROUND(CHG/BASE*100,0.01);
END;
RUN;
PROC PRINT DATA=BASELINE;
RUN;
