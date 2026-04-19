	/**************************************************************************
	Program Name   : suppdm_raceoth.sas
	Project        : SDTM DM & SUPPDM Development
	Study          : 009/01
	Programmer     : Nithish M S
	Date Created   : 02-APR-2026
	Last Modified  : 20-APR-2026
	
	Description    :
	This program creates the SUPPDM dataset from the DM domain.
	It derives supplemental qualifier RACEOTH using ETHO variable
	from raw demographic data and maps it into SDTM structure.
	
	Input Data     :
	- DM (Demographics dataset)
	
	Output Data    :
	- SUPPDM (Supplemental Qualifiers for DM)
	
	Macros Used    : None
	
	SAS Version    : SAS Studio
	
	Notes          :
	- QNAM = RACEOTH
	- QVAL = ETHO
	- QORIG = CRF
	- Only non-missing ETHO values are considered
	
	 **************************************************************************/
	/* SUPPLIMENTRY DOMINE */
	PROC IMPORT DATAFILE="/home/u64168920/Project SDTM DM Raw datafile.xlsx" 
  OUT=DM 
			DBMS=XLSX REPLACE;
		GETNAMES=YES;
	RUN;
	
	DATA SUPPDM;
		SET DM;
	
		IF ETHO ^=" ";
		STUDYID=STRIP(STUDY);
		RDOMAIN="DM";
		SITEID=STRIP(SITE);
		USUBJID=CATX("-", STUDYID, SITEID, SUBJID);
		IDVAR="";
		IDVARVAL="";
		QNAM="RACEOTH";
		QLABEL="RACE,OTHER";
		QVAL=ETHO;
		QORIG="CRF";
		QEVAL=INV;
	RUN;
	
	DATA SUPPDM1;
		SET SUPPDM;
		KEEP STUDYID RDOMAIN USUBJID IDVAR IDVARVAL QNAM QLABEL QVAL QORIG QEVAL;
	RUN;
	
	PROC PRINT DATA=SUPPDM1;RUN;
	
/* 	LABEL VARIABLE */
	PROC SQL;
		CREATE TABLE SUPP_FINAL AS SELECT STUDYID LABEL="STUDY IDENTFIER" , RDOMAIN 
			LABEL="RELATED DOMINE ABBREVATION", USUBJID LABEL="UNIQUE SUBJECT VARIABLE", 
			IDVAR LABEL="IDENTIFYING VARIABLE", IDVARVAL 
			LABEL="IDENTIFYING VARIALE VALUE", QNAM LABEL="QUALIFIER VARIABL NAME", 
			QLABEL LABEL="QUALIFIER VARIABLE LABEL", QVAL LABEL="DATA VALUE", QORIG 
			LABEL="ORIGIN", QEVAL LABEL="EVALUATOR" FROM SUPPDM1;
	QUIT;
	
	
/* 	EXPORT DATA IN XPT FORM */
	LIBNAME XPTOUT XPORT "/home/u64168920/file/suppdm.xpt";
	
	DATA XPTOUT.suppdm;
	SET SUPP_FINAL;
	RUN;
	
	LIBNAME XPTOUT CLEAR;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
