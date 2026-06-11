
DATA ADSL1;
SET pg1.DM2;
SAER = CATX("/",SEX,AGE,RACE);
CONSDT = INPUT(RFICDTC,YYMMDD10.);
CONSDTC = PUT(RFICDTC,YYMMDD10.);
FORMAT CONSDT E8601DA.;
IF CONSDT NE "" THEN ENRLFL = "Y";
ELSE ENRLFL="N";

IF RFXSTDTC NE "" THEN SAFFL="Y";
ELSE SAFFL="N";
RUN;

DATA ADSL2;
SET ADSL1;
DTM=RFSTDTC;
TRTSDT=INPUT(SCAN(RFSTDTC,1,"T"),YYMMDD10.);
TRTSTM=INPUT(SCAN(RFSTDTC,-1,"T"),TIME8.);
TRTSDTM=INPUT(RFSTDTC,YYMMDD10.);
FORMAT TRTSDTM E8601DA.;
format TRTSDT iso8601da.;
format TRTSTM tod8.;

ETM=RFENDTC;
TRTEDT=INPUT(SCAN(RFENDTC,1,"T"),YYMMDD10.);
TRTETM=INPUT(SCAN(RFENDTC,-1,"T"),TIME8.);
TRTEDTC=ETM;
format TRTEDT e8601da.;
format TRTETM tod8.;
RUN;

DATA ADSL3;
SET ADSL2;
IF CONSDT <TRTSDT THEN CONSDY=CONSDT - TRTSDT;
ELSE IF CONSDT>=TRTSDT THEN CONSDY=CONSDT-TRTSDT+1;
RUN;

DATA ADSL4;
SET ADSL3;
IF AGE LT 25 THEN DO;
AGEGR1 = "=<25 Years";
AGEGR1N=1;
END;

ELSE IF AGE GE 25 THEN DO;
AGEGR1 = ">=26 Years";
AGEGR1N=2;
END;
RUN;

DATA ADSL_FINAL;
SET ADSL4;
KEEP 
STUDYID
Usubjid
SITEID
SUBJID
Country
INVNAM
SAER
CONSDT
CONSDTC
CONSDY
ENRLFL
SAFFL
TRTSDTC
TRTSDT
TRTSTM
TRTSDTM
TRTEDTC
TRTEDT
TRTETM
TRTEDTM
AGE
AGEGR1
AGEGR1N ;
RUN;

proc sql;
create table DM as
select
STUDYID length=25 label="Study Identifier",
USUBJID length=25 label="Unique Subject Identifier",
SITEID length=3   label="Study SITE ID",
SUBJID length=25  label="Subject Identifier",
COUNTRY length=25 label="Country",
INVNAM length=100 label="Investigator Name",
SAER length=50    label="Sex/Age/Ethnicity/Race",
CONSDT            label="Date of Informed Consent (Num)",
CONSDTC length=19 label="Date of Informed Consent",
CONSDY            label="Day of Informed Consent",
ENRLFL length=1   label="Enrolled Analysis Set Flag",
SAFFL length=1    label="Safety Analysis Set Flag",
TRTSDT            label="Date of First Exposure to TRT (Num)",
TRTSTM length=8   label="Time of First Exposure to Treatment",
TRTSDTM           label="Date/Time of First Exposure to Treatment (Num)",
TRTEDTC length=19 label="Date/Time of Last Exposure to TRT",
TRTEDT            label="Date of Last Exposure to Treatment (Num)",
TRTETM length=8   label="Time of Last Exposure to Treatment",
AGE               label="Age",
AGEGR1 length=20  label="Age Group",
AGEGR1N label="Age Group Number"
from ADSL_FINAL;
quit;


proc print data=dm (firstobs=1 obs=10);
run;




