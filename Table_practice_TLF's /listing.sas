/* listing project ADSL-ADVS */
 
PROC IMPORT DATAFILE="/home/u64252598/SAS/New Folder/adsl_tlf_practice.csv"
OUT=adsl
DBMS=CSV REPLACE;
GETNAMES=YES;
QUIT;

PROC IMPORT DATAFILE="/home/u64252598/SAS/New Folder/advs_tlf_practice.csv"
OUT=advs
DBMS=CSV REPLACE;
GETNAMES=YES;
QUIT;

proc sql;
create table adsl_advs as select 
advs.usubjid,advs.trtp,advs.trtpn,advs.param,advs.avisit,
advs.aval,adsl.usubjid,adsl.sex,adsl.country,adsl.age
from advs left join adsl
on advs.usubjid=adsl.usubjid;
quit;


proc format;
value $ gender "M"="Male"
"F"="Female";
run;

proc report data=adsl_advs headline headskip split="*";
col usubjid sex country age trtp trtpn param aval;

define usubjid/order "Subject*Identifier";
define sex/format=$gender. order;
define country/order;
define age/order;
define trtp/order;
define trtpn/order noprint;
define param/order;
define avisit/order;

break after param/skip;

compute before _page_;
line @7 "BP3304-002" @180"1_Vitals.sas";
line " ";
line " ";
line @30 "Subject vitals signs information - listings";
endcomp;
run;
