/*************************************************************************/
/* ADSL IMPORT */
/*************************************************************************/

PROC IMPORT DATAFILE="/home/u64252598/Project AE Table raw file Adverse_ADSL.xlsx"
OUT=ADSL_RAW
DBMS=XLSX REPLACE;
GETNAMES=YES;
RUN;

/*************************************************************************/
/* SAFETY POPULATION */
/*************************************************************************/

DATA ADSL;
SET ADSL_RAW;

IF SAFFL='Y';

IF INDEX(UPCASE(TRT01A),'100 MG TG3304')>0 THEN DO;
    TRT='A';
    ORD=1;
END;
ELSE IF INDEX(UPCASE(TRT01A),'PLACEBO')>0 THEN DO;
    TRT='B';
    ORD=2;
END;

KEEP USUBJID TRT ORD;
RUN;

/*************************************************************************/
/* BIG N */
/*************************************************************************/

PROC SQL NOPRINT;
SELECT COUNT(DISTINCT USUBJID)
INTO :N1-:N2
FROM ADSL
GROUP BY ORD
ORDER BY ORD;
QUIT;

%PUT N1=&N1;
%PUT N2=&N2;

/*************************************************************************/
/* ADAE IMPORT */
/*************************************************************************/

PROC IMPORT DATAFILE="/home/u64252598/Project AE Table raw file Adverse_ADAE.xlsx"
OUT=ADAE_RAW
DBMS=XLSX REPLACE;
GETNAMES=YES;
RUN;

/*************************************************************************/
/* TEAE SAFETY POPULATION */
/*************************************************************************/

DATA ADAE;
SET ADAE_RAW;

IF SAFFL='Y' AND TEAEFL='Y';

IF INDEX(UPCASE(TRTA),'100 MG TG3304')>0 THEN DO;
    TRT='A';
    ORD=1;
END;
ELSE IF INDEX(UPCASE(TRTA),'PLACEBO')>0 THEN DO;
    TRT='B';
    ORD=2;
END;
RUN;

/*************************************************************************/
/* ANY TEAE */
/*************************************************************************/

PROC SQL;
CREATE TABLE ANY AS
SELECT 1 AS LEVEL,
       1 AS SOCORD,
       "Number of Subjects with TEAEs" AS TERM LENGTH=200,
       TRT,
       ORD,
       COUNT(DISTINCT USUBJID) AS N
FROM ADAE
GROUP BY TRT,ORD;
QUIT;

/*************************************************************************/
/* SOC */
/*************************************************************************/

PROC SQL;
CREATE TABLE SOC AS
SELECT 2 AS LEVEL,
       MONOTONIC() AS SOCORD,
       AEBODSYS AS TERM LENGTH=200,
       TRT,
       ORD,
       COUNT(DISTINCT USUBJID) AS N
FROM ADAE
GROUP BY AEBODSYS,TRT,ORD;
QUIT;

/*************************************************************************/
/* PT */
/*************************************************************************/

PROC SQL;
CREATE TABLE PT AS
SELECT 3 AS LEVEL,
       AEBODSYS,
       AEDECOD,
       TRT,
       ORD,
       COUNT(DISTINCT USUBJID) AS N
FROM ADAE
GROUP BY AEBODSYS,AEDECOD,TRT,ORD;
QUIT;

/*************************************************************************/
/* CALCULATE PERCENTAGES */
/*************************************************************************/

DATA ANY2 SOC2;

SET ANY SOC;

LENGTH RESULT $20;

IF TRT='A' THEN PCT=(N/&N1)*100;
ELSE IF TRT='B' THEN PCT=(N/&N2)*100;

RESULT=CATS(PUT(N,3.),' (',PUT(PCT,5.1),')');

KEEP LEVEL SOCORD TERM TRT RESULT;
RUN;

DATA PT2;
SET PT;

LENGTH TERM $200 RESULT $20;

TERM=CATS('    ',AEDECOD);

IF TRT='A' THEN PCT=(N/&N1)*100;
ELSE IF TRT='B' THEN PCT=(N/&N2)*100;

RESULT=CATS(PUT(N,3.),' (',PUT(PCT,5.1),')');

KEEP LEVEL AEBODSYS TERM TRT RESULT;
RUN;

/*************************************************************************/
/* TRANSPOSE ANY */
/*************************************************************************/

PROC TRANSPOSE DATA=ANY2 OUT=ANYT(DROP=_NAME_);
BY LEVEL SOCORD TERM;
ID TRT;
VAR RESULT;
RUN;

/*************************************************************************/
/* TRANSPOSE SOC */
/*************************************************************************/

PROC TRANSPOSE DATA=SOC2 OUT=SOCT(DROP=_NAME_);
BY LEVEL SOCORD TERM;
ID TRT;
VAR RESULT;
RUN;

/*************************************************************************/
/* TRANSPOSE PT */
/*************************************************************************/

PROC SORT DATA=PT2;
BY AEBODSYS TERM;
RUN;

PROC TRANSPOSE DATA=PT2 OUT=PTT(DROP=_NAME_);
BY AEBODSYS TERM;
ID TRT;
VAR RESULT;
RUN;

/*************************************************************************/
/* MERGE SOC + PT */
/*************************************************************************/

DATA SOCPT;
SET SOCT PTT;
RUN;

/*************************************************************************/
/* FINAL TABLE */
/*************************************************************************/

DATA FINAL;
SET ANYT SOCPT;
RUN;

PROC PRINT DATA=FINAL NOOBS LABEL;
VAR TERM A B;
LABEL
TERM='MedDRA System Organ Class / Preferred Term'
A="100 MG TG3304 (N=&N1)"
B="PLACEBO (N=&N2)";
RUN;
