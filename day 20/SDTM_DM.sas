************************/* DM_PROJECT_PRACTICE */*************************************

/* Import Demographic raw data */;
PROC IMPORT DATAFILE="/home/u64168920/Project SDTM DM Raw datafile.xlsx" 
		OUT=WORK.DM DBMS=XLSX REPLACE;
RUN;

DATA DM1;
	SET DM;
	STUDYID=STRIP(STUDY);
	DOMAIN="DM";
	SUBJID=STRIP(SUBJID);
	SITEID=STRIP(SITE);
	USUBJID=COMPRESS(STUDYID||"-"||SITEID||"-"||SUBJID);
	RFICDTC=PUT(infdt, IS8601DA.)||"T"||PUT(inftm, TOD8.);
	FORMAT CMPDT DATE9.;
	RFPENDTC=PUT(CMPDT, E8601DA.)||"T"||PUT(CMPTM, TOD8.);
	RFSTDTC=PUT(ENTDT, ISO8601DA.)||"T"||PUT(ENRTM, TOD8.);
	RFENDTC=PUT(CMPDT, E8601DA.)||"T"||PUT(CMPTM, TOD8.);
	DTHDTC="";
	DTHFL="null";
	INVNAM=strip(inv);
	AGE=AGEUN;
	AGEU="YEARS";
	SEX=SUBSTR(GEN, 1, 1);
	RACE=UPCASE(ETH);
RUN;

/* IMPORT EXPOSURE DOMAIN */
PROC IMPORT DATAFILE="/home/u64168920/Project SDTM Exposure Raw datafile.xlsx" 
		OUT=EX DBMS=XLSX REPLACE;
	GETNAMES=YES;
RUN;

DATA EX1;
	SET EX;
	WHERE VISIT="Period-1";
	STUDYID=STRIP(STUDY);
	DOMAIN="EX";
	SUBJID=STRIP(SUBJID);
	SITEID=STRIP(SITE);
	USUBJID=COMPRESS(STUDYID||"-"||SITEID||"-"||SUBJID);
	RFXSTDTC=PUT(DSDT, ISO8601DA.)||"T"||PUT(DSDTM, TOD8.);
RUN;

DATA EX2;
	SET EX;
	WHERE VISIT="Period-2";
	STUDYID=STRIP(STUDY);
	DOMAIN="EX";
	SUBJID=STRIP(SUBJID);
	SITEID=STRIP(SITE);
	USUBJID=COMPRESS(STUDYID||"-"||SITEID||"-"||SUBJID);
	RFXENDTC=PUT(DSDT, ISO8601DA.)||"T"||PUT(DSDTM, TOD8.);
RUN;

PROC SORT DATA=EX1 OUT=EX3;
	BY USUBJID;
RUN;

PROC SORT DATA=EX2 OUT=EX4;
	BY USUBJID;
RUN;

DATA EX5;
	MERGE EX3(IN=A) EX4(IN=B);
	BY USUBJID;

	IF A AND B;
	KEEP USUBJID RFXSTDTC RFXENDTC;
RUN;

PROC SORT DATA=DM1 OUT=DM2;
	BY USUBJID;
RUN;

PROC SORT DATA=EX5 OUT=EX6;
	BY USUBJID;
RUN;

DATA DM3;
	MERGE DM2(IN=A) EX6(IN=B);
	BY USUBJID;

	IF A AND B;
RUN;

/* IMPORT RANDOMIZATION RAW DATA */
PROC IMPORT 
		DATAFILE="/home/u64168920/Project SDTM Randomization Raw datafile.xlsx" 
		OUT=RD DBMS=XLSX REPLACE;
	GETNAMES=YES;
RUN;

DATA RD1;
	SET RD;
	ARM=STRIP(ARMDP);
	ARMCD=STRIP(ARMP);
	ACTARMCD=STRIP(ARMA);
	ACTARM=STRIP(ARMDA);

	IF MISSING(ARMCD) THEN
		DO;
			ARM="";
			ARMNRS="NOT ASSIGNED";
		END;

	IF MISSING(ACTARMCD) THEN
		DO;
			ACTARM="";
			ARMNRS="NOT TREATED";
		END;
	KEEP SUBJID ARM ARMCD ACTARMCD ACTARM;
RUN;

PROC SORT DATA=DM3 OUT=DM4;
	BY SUBJID;
RUN;

PROC SORT DATA=RD1 OUT=RD2;
	BY SUBJID;
RUN;

DATA DM5;
	MERGE DM4(IN=A) RD2(IN=B);
	BY SUBJID;

	IF A AND B;
RUN;

DATA DM6;
	SET DM5;
	COUNTRY="INDIA";
	DMDTC="";
	DMDY="";
	KEEP STUDYID DOMAIN USUBJID SUBJID SITEID RFSTDTC RFENDTC RFXSTDTC RFXENDTC 
		RFICDTC RFPENDTC DTHDTC DTHFL INVNAM AGE AGEU SEX RACE ARMCD ARM 
		ACTARMCD ACTARM COUNTRY DMDTC DMDY;
RUN;

proc sql;
    create table dm_final as 
    select 
        STUDYID label="Study Identifier" length=8,
        DOMAIN  label="Domain Abbreviation" length=2,
        USUBJID label="Unique Subject Identifier" length=50,
        SUBJID  label="Subject Identifier for the Study" length=50,
        SITEID  label="Study Site Identifier" length=20,
        RFSTDTC label="Subject Reference Start Date/Time" length=25,
        RFENDTC label="Subject Reference End Date/Time" length=25,
        RFXSTDTC label="Date/Time of First Study Treatment" length=25,
        RFXENDTC label="Date/Time of Last Study Treatment" length=25,
        RFICDTC label="Date/Time of Informed Consent" length=25,
        RFPENDTC label="Date/Time of End of Participation" length=25,
        DTHDTC  label="Date/Time of Death" length=25,
        DTHFL   label="Subject Death Flag" length=2,
        INVNAM  label="Investigator Name" length=100,
        AGE     label="Age" length=8,
        AGEU    label="Age Units" length=6,
        SEX     label="Sex" length=2,
        RACE    label="Race" length=100,
        ARMCD   label="Planned Arm Code" length=100,
        ARM     label="Description of Planned Arm" length=200,
        ACTARMCD label="Actual Arm Code" length=100,
        ACTARM   label="Description of Actual Arm" length=200,
        COUNTRY label="Country" length=50,
        DMDTC   label="Date/Time of Collection" length=25,
        DMDY    label="Study Day of Collection"
    from DM6;
quit;

DATA DM_FINAL (LABEL=Demographic);
set dm_final;
run;

PROC PRINT DATA=DM_FINAL (FIRSTOBS=1 OBS=10);
RUN;

LIBNAME XPTOUT XPORT "/home/u64168920/project_sdtm/DM_FINAL.XPT";

DATA XPTOUT.DM_FINAL;
SET DM_FINAL;
RUN;

LIBNAME XPTOUT CLEAR;
