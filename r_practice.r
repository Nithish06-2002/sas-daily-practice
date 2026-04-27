library(readxl)
library(dplyr)
library(stringr)
library(lubridate)
library(haven)
library(tidyverse)

dm<-read_xlsx('/Users/nithish/Desktop/ pharmaxene youtube /Project work/sas(hirelink)/Project SDTM DM Raw datafile (1).xlsx')
dm

names(dm)

dm1<-dm %>% 
  mutate(
    STUDYID = str_trim(STUDY),
    DOMAIN = "DM",
    SUBJID = str_trim(SUBJID),
    SITEID = str_trim(SITE),
    
    USUBJID = str_c(STUDYID,SITEID,SUBJID,sep = "-"),
    
    ENTDT = lubridate::dmy(ENTDT),
    CMPDT = lubridate::dmy(CMPDT),
    infdt = lubridate::dmy(infdt),
    
    RFICDTC = paste0(format(infdt,"%Y-%m-%d"), "T", format(inftm, "%H:%M:%S")),
    RFPENDTC = paste0(format(CMPDT,"%Y-%m-%d"), "T", format(CMPTM,"%H:%M:%S")),
    RFSTDTC = paste0(format(ENTDT,"%Y-%m-%d"), "T", format(ENRTM,"%H:%M:%S")),
    RFENDTC = paste0(format(CMPDT,"%Y-%m-%d"), "T", format(CMPTM,"%H:%M:%S")),
    
    DTHDTC = "",
    DTHFL = "NULL",
    
    INVENAM = str_trim(inv),
    
    AGE = AGEUN,
    AGEU = "Years",
    
    SEX = str_sub(GEN,1,1),
    RECE = str_to_upper(ETH)
  )

View(dm1)
str(dm$ENTDT)
str(dm$ENRTM)

ex<-read_excel('/Users/nithish/Desktop/ pharmaxene youtube /Project work/sas(hirelink)/Project SDTM Exposure Raw datafile (2).xlsx')
ex

str(ex)

str(ex$DSDT)
str(ex$DSDTM)

ex1 <- ex %>%
  filter(VISIT == "Period-1") %>%
  mutate(
    STUDYID = str_trim(STUDY),
    DOMAIN = "EX",
    SUBJID = str_trim(SUBJID),
    SITEID = str_trim(SITE),
    
    USUBJID = str_c(STUDYID, SITEID, SUBJID, sep = "-"),
    
    DSDT = lubridate::dmy(DSDT),
    DSDTM = hms::as_hms(DSDTM),
    
    RFXSTDTC = paste0(
      format(DSDT, "%Y-%m-%d"),
      "T",
      format(DSDTM, "%H:%M:%S")
    )
  ) %>%
  select(USUBJID, RFXSTDTC)

class(ex1)
  
View(ex1)
