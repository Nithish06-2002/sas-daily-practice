/**************************************************************************/
Program Name   : EX_SDTM.sas
Project        : SDTM Exposure Domain Development
Study          : 009/01
Author         : Nithish M S
Date Created   : 26MAR2026
Platform       : SAS 9.4

---------------------------------------------------------------------------
Description:
This program creates the SDTM Exposure (EX) domain dataset from raw data.
It includes derivation of key variables such as:
- USUBJID (Unique Subject Identifier)
- EXSTDTC / EXENDTC (ISO8601 datetime)
- EXSTDY / EXENDY (Study day variables)
- EXDUR (Duration of exposure)
- EXSEQ (Sequence number within subject)

The program integrates EX and DM datasets to calculate study day variables
based on reference start date (RFSTDTN).

---------------------------------------------------------------------------
Input Datasets:
- Raw Exposure Dataset (Excel)
- Raw Demographics Dataset (Excel)

---------------------------------------------------------------------------
Output Datasets:
- FINAL_EX  : SDTM-compliant Exposure dataset
- EX_FINAL  : Final labeled dataset
- XPT File  : Exposure.xpt (submission-ready)

---------------------------------------------------------------------------
Key Processing Steps:
1. Import raw EX and DM datasets
2. Derive SDTM variables (USUBJID, EXTRT, EXDOSE, etc.)
3. Convert dates to ISO8601 format
4. Merge EX with DM to calculate study day variables
5. Derive EXSEQ using BY-group processing
6. Create final dataset with required variables
7. Export dataset to XPT format

---------------------------------------------------------------------------
Notes:
- EXSEQ is assigned sequentially within USUBJID
- Date variables follow ISO8601 standard
- Duration (EXDUR) is derived as per SDTM guidelines

---------------------------------------------------------------------------
Modification History:
---------------------------------------------------------------------------
Date        Author        Description
---------------------------------------------------------------------------
27MAR2026   Nithish       Initial version
**************************************************************************/

/* RAW DATA IMPORT */
PROC IMPORT DATAFILE="/home/u64168920/Project SDTM Exposure Raw datafile.xlsx"
OUT=EX
DBMS=XLSX REPLACE;
RUN;

DATA EX1;
SET EX;
STUDYID=STRIP(STUDY);
DOMAIN="EX";
SITEID=STRIP(SITE);
SUBJECT=STRIP(SUBJID);
USUBJID=STRIP(STUDYID)||"-"||STRIP(SITEID)||"-"||STRIP(SUBJID);
EXTRT=STRIP(TRT);
EXDOSE=INPUT(SUBSTR(DOSE,1,2),BEST.);
EXDOSU=SUBSTR(DOSE,3,4);
EXDOSTXT=DOSEN;
EXDOSFRQ=UPCASE(FREQ);
EXROUTE=UPCASE(ROUTE);
EXFAST=UPCASE(SUBSTR(FAST,1,1));

DSDTN=INPUT(DSDT,MMDDYY10.);
EXSTDTC=PUT(DSDTN,IS8601DA.)||"T"||PUT(DSDTM, TOD8.);
EXSTDTN=DATEPART(INPUT(EXSTDTC,IS8601DT.));
FORMAT EXSTDTN DATE9.;

EXENDTC=PUT(DSDTN,IS8601DA.)||"T"||PUT(DSDTM,TOD8.);
EXENDTN=DATEPART(INPUT(EXENDTC,IS8601DT.));
FORMAT EXENDTN DATE9.;
RUN;

PROC IMPORT DATAFILE="/home/u64168920/Project SDTM DM Raw datafile.xlsx"
OUT=DM
DBMS=XLSX REPLACE;
GETNAMES=YES;
QUIT;

DATA DM1;
SET DM;
STUDYID=STRIP(STUDY);
DOMAIN="DM";
SITEID=STRIP(SITE);
SUBJECT=STRIP(SUBJID);
USUBJID=STRIP(STUDYID)||"-"||STRIP(SITEID)||"-"||STRIP(SUBJID);
ENRDTN=INPUT(ENTDT,MMDDYY10.);
RFSTDTC=PUT(ENRDTN,IS8601DA.)||"T"||PUT(ENRTM,TOD8.);
RFSTDTN=DATEPART(INPUT(RFSTDTC,IS8601DT.));
KEEP USUBJID RFSTDTN RFSTDTC; 
FORMAT RFSTDTN DATE9.;
RUN;

PROC SORT DATA=EX1 OUT=EX3;BY USUBJID;RUN;
PROC SORT DATA=DM1 OUT=DM3;BY USUBJID;RUN;

DATA DM_EX;
MERGE DM3(IN=A) EX3(IN=B);
BY USUBJID;
IF A AND B;
RUN;

DATA EX2;
SET DM_EX;
IF EXSTDTN > . AND RFSTDTN > . THEN DO;
IF EXSTDTN>=RFSTDTN THEN EXSTDY=EXSTDTN-RFSTDTN+1;
ELSE IF EXSTDTN<RFSTDTN THEN EXSTDY=EXSTDTN-RFSTDTN;
END;

IF EXENDTN > . AND RFSTDTN > . THEN DO;
IF EXENDTN >= RFSTDTN THEN EXENDY = EXENDTN - RFSTDTN + 1;
ELSE IF EXENDTN < RFSTDTN THEN EXENDY = EXENDTN - RFSTDTN;
END;

EXDUR1=EXENDY-EXSTDY+1;
EXDUR=("P"||PUT(EXDUR1,BEST.)||"D");
EXDUR=COMPRESS(EXDUR);
EXDOSFRM=STRIP(DOSTP);
RUN;

proc sort data=EX2; by USUBJID EXSTDTN; run;

data EX4;
length EXSEQ 8;
set EX2;
by USUBJID EXSTDTN;
if first.USUBJID then EXSEQ = 1;
else EXSEQ + 1;
keep USUBJID EXSTDTN EXSEQ;
run;

proc sort data=EX2; by USUBJID EXSTDTN; run;

data FINAL;
merge EX2 EX4;
by USUBJID EXSTDTN;
if first.USUBJID then EXSEQ = 1;
else EXSEQ + 1;
keep 
STUDYID DOMAIN USUBJID EXTRT EXDOSE EXDOSU EXDOSTXT
EXDOSFRM EXDOSFRQ EXROUTE EXFAST EPOCH EXSTDTC EXENDTC
EXSTDY EXENDY EXDUR EXSEQ;
run;

proc print data=final (firstobs=1 obs=10);
run;

/* LABEL */
proc sql;
create table FINAL_EX as
select
STUDYID length=8 label="Study Identifier",
DOMAIN length=2 label="Domain Abbreviation",
USUBJID length=50 label="Unique Subject Identifier",
EXTRT length=200 label="Name Of Treatment",
EXDOSE length=8 label="Dose",
EXDOSU length=40 label="Dose Units",
EXDOSTXT length=40 label="Dose Description",
EXDOSFRM length=80 label="Dose Form",
EXDOSFRQ length=40 label="Dosing Frequency Per Interval",
EXROUTE length=40 label="Route Of Administration",
EXFAST length=40 label="Fasting Status",
EXSTDTC length=20 label="Start Date/Time of Treatment",
EXENDTC length=20 label="End Date/Time of Treatment",
EXSTDY length=8 label="Study Day of Start of Treatment",
EXENDY length=8 label="Study Day of End of Treatment",
EXDUR length=20 label="Duration of Treatment",
EXSEQ length=8 label="Sequence Number"
from FINAL;
quit;

data EX_FINAL (LABEL=Exposure);
SET FINAL_EX;
RUN;

/* XPT OUTPUT */
LIBNAME XPTOUT XPORT "/home/u64168920/Project_work_01/EXPOSURE.xpt";

DATA XPTOUT.EXPOSURE;
SET FINAL_EX;
RUN;

LIBNAME XPTOUT CLEAR;
