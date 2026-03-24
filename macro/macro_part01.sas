*Automatie the repetitive task
sas macro are useful when we want to execute same set of sas statment agani 
and again, this is an ideal case for use of macro rather than
typing /copy pasting same sentance.

Components of macro code:
Consists of two building blocks:Macros and Macro variables.

Macro Variables:1.Local
                2.Global
To creating a macro variable:

%LET <macro-variable name>=Value
%GLOBAL<macro-variable name>=Value
%LOCAL <macro-variable name>=Value

Global:"Global macro variable" it is defined in "open code" which is everything outside a macro .you can use a global 
macro variable anyware in yout program

local:"local macvro variable" it is defined inside a macro .you can use
a local macro variable only inside its own macro.                
;

proc print data=&x;
run;

proc sort data=&x out=class;
by sex;
run;

data fclass;
set &x;
where sex="F";
run;

data mclass;
set &x;
where sex="M";
run;

%LET X=sashelp.class;

Macro and macro variable

proc print data=sashelp.class;
run;

proc print data=sashelp.air;
run;

proc print data=sashelp.cars;
run;

proc print data=sashelp.shoes;
run;

macro
%macro print;
proc print data=sashelp.cars;
run;
%mend;

call macro
%print;

parameters (keyworld and positional parameters)
%macro print(dname=);
proc print data=&dname;
run;
%mend;

%print(dname=sashelp.class);
%print(dname=sashelp.cars);
%print(dname=sashelp.air);



%macro print(dname);
proc print data=&dname;
run;
%mend;


%print(sashelp.class);
%print(sashelp.cars);
%print(sashelp.air);


macro programming for subsetting data

%macro sub(d=,r=,var=,val=);
data &d;
set &r;
where &var=&val;
run;
%mend

%sub(d=nithi,r=sashelp.class,var=sex,val="M");
%sub(d=nithi,r=sashelp.class,var=sex,val="F");
%sub(d=cars1,r=sashelp.cars,var=make,val="Audi");


*Positional parameters :in this method we supply parameter name at thime of defining the macro

Syntax */;
%macro<macro name>(parameteri......n);
Macro statment;
%mend
calling:
%macroname (value1...value-n);

*Keyworld parameters: inthis method we provide parameter name with quals 
to sign and also can assign default value to the parameter

syntax */;
%macro <macro name> (parameter1=value.......parameter-n=value);
macro statment;
%mend;
calling:
%macroname (parameter1=vale,......parameter-n=value);



%macro dv(name=, path=);
   libname &name "&path";
%mend;

%dv(name=lib, path=/home/u64252598);



/* macro for procedure variable */
;

proc sort data=sashelp.class out=class;
   by sex;
run;

proc freq data=class;
table age;
by sex;
quit;
