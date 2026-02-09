/* 1. String functions */

data n;
set sashelp.deskact;

action = compress(action,"_");
objtype = upcase(objtype);
desc = tranwrd(desc,"Submit","XYZ");
action = propcase(action);
poss = (pos/220)*100;
format poss 8.;
newcol = catx("/",action,desc,poss);

run;


/* 2. IF used to filter data */

data pd;
set sashelp.baseball;

name_clean = upcase(compress(name,","));
if upcase(team)="CHICAGO";

run;


/* 3. Numeric filter */

data b;
set sashelp.bweight;

if weight=48000;

run;


/* 4. IF THEN action */

data c;
set sashelp.fish;

if species="Bream" then value=1;

run;

proc print data=c;
run;


/* 5. IF ELSE IF */

data s;
set sashelp.deskact;

if where=1 then place="X";
else if where=2 then place="Y";

run;


data l;
set sashelp.deskact;

if where=1 then place="X";
else if where=3 then place="Y";

run;


/* 6. Multiple datasets using OUTPUT */

data x y;
set sashelp.failure;

if process="Process A" then output x;
else if process="Process B" then output y;

run;


/* 7. Using _N_ */

data obs_select;
set sashelp.bmt;

if _N_ in (13,18,21);

run;
