/*------------------------------------------------*/
/* STRIP vs TRIM                                  */
/* STRIP  → removes leading + trailing blanks     */
/* TRIM   → removes only trailing blanks           */
/*------------------------------------------------*/

data i;
k = "            sa             s               ";

l = strip(k);   /* Both leading & trailing blanks removed */
a = trim(k);    /* Only trailing blanks removed */

run;


/*------------------------------------------------*/
/* WHERE + UPCASE example                         */
/*------------------------------------------------*/

data nithi;
set sashelp.heart;

Sex = upcase(sex);

where BP_Status = "Normal";

run;


/*------------------------------------------------*/
/* Check variable names vs labels                 */
/*------------------------------------------------*/

proc contents data=sashelp.heart;
run;


/*------------------------------------------------*/
/* Create variables + assign labels               */
/*------------------------------------------------*/

data patients;

name = "Nithi";
age  = 24;
bp_status = "Normal";
label
name      = "Patient Name"
age       = "Patient Age"
bp_status = "Blood Pressure Status";
run;

proc print data=patients label;
run;


/*------------------------------------------------*/
/* SUBSTR → Extract part of string                */
/* Syntax: var = substr(string,start,length);     */
/*------------------------------------------------*/

data n;
x = "clinical sas programming";
y = substr(x,1,8);   /* Extract first 8 characters */
run;


/*------------------------------------------------*/
/* SCAN → Extract word from string                */
/* Syntax: var = scan(string,word_number);        */
/*------------------------------------------------*/

data o;
x = "clinical sas programming";
y = scan(x,-2);   /* 2nd word from right → SAS */
run;


/*------------------------------------------------*/
/* INDEX → Find pattern position                  */
/* Syntax: var = index(string,"pattern");         */
/*------------------------------------------------*/

data p;
q = "CliNiCal TriAl Phases";
d = index(q,"Ca");   /* Case sensitive search */
run;


/*------------------------------------------------*/
/* INDEXC → Find character position               */
/* Syntax: var = indexc(string,"characters");     */
/*------------------------------------------------*/

data g;
q = "CliNiCal TriAl Phases";
w = indexc(q,"TN");   /* First occurrence of T or N */
run;


/*------------------------------------------------*/
/* INDEXW → Find word position                    */
/* Syntax: var = indexw(string,"word");           */
/*------------------------------------------------*/

data u;
f = "CliNiCal TriAl Phases";
h = indexw(f,"Phases");
run;

/*====================================================*/
/* CHARACTER FUNCTIONS – REVISION PROGRAM (ALL-IN-ONE)*/
/* Name used: Nithi Kumar                             */
/*====================================================*/

data char_functions_demo;

/*----------------------------------*/
/* Base strings                     */
/*----------------------------------*/

name1 = "nithi kumar";
name2 = "NITHI KUMAR";
name3 = "nithi,kumar";
name4 = "  Nithi Kumar  ";
name5 = "Nithi   ";
sentence = "I like SAS programming";


/*----------------------------------*/
/* 1. UPCASE                        */
/* Syntax: var = upcase(string);    */
/*----------------------------------*/

ex_upcase = upcase(name1);


/*----------------------------------*/
/* 2. LOWCASE                       */
/* Syntax: var = lowcase(string);   */
/*----------------------------------*/

ex_lowcase = lowcase(name2);


/*----------------------------------*/
/* 3. PROPCASE                      */
/* Syntax: var = propcase(string);  */
/*----------------------------------*/

ex_propcase = propcase(name1);


/*----------------------------------*/
/* 4. LENGTH                        */
/* Syntax: var = length(string);    */
/*----------------------------------*/

ex_length = length(name1);


/*----------------------------------*/
/* 5. CAT                           */
/* Syntax: var = cat(str1,str2);    */
/*----------------------------------*/

ex_cat = cat("Nithi","Kumar");


/*----------------------------------*/
/* 6. CATX                          */
/* Syntax: var = catx("sep",str1,str2); */
/*----------------------------------*/

ex_catx = catx(" ","Nithi","Kumar");


/*----------------------------------*/
/* 7. COMPRESS (remove character)   */
/* Syntax: var = compress(string,","); */
/*----------------------------------*/

ex_compress_char = compress(name3,",");


/*----------------------------------*/
/* 8. COMPRESS (remove spaces)      */
/* Syntax: var = compress(string);  */
/*----------------------------------*/

ex_compress_space = compress("Nithi Kumar");


/*----------------------------------*/
/* 9. TRANSLATE                     */
/* Syntax: translate(string,"new","old"); */
/*----------------------------------*/

ex_translate = translate("Nithi Kumar","P","N");


/*----------------------------------*/
/* 10. TRANWRD                      */
/* Syntax: tranwrd(string,"old","new"); */
/*----------------------------------*/

ex_tranwrd = tranwrd(sentence,"SAS","Python");


/*----------------------------------*/
/* 11. STRIP                        */
/* Syntax: strip(string);           */
/*----------------------------------*/

ex_strip = strip(name4);


/*----------------------------------*/
/* 12. TRIM                         */
/* Syntax: trim(string);            */
/*----------------------------------*/

ex_trim = trim(name5);


run;


/* Display Results */

proc print data=char_functions_demo;
run;
