/* macro/macro_part01.sas - keyword and positional macro parameters */
/* Two macros from the lesson: a parameterized printer, and a subsetter. */

/* Keyword-parameter macro - print any dataset */
%macro print(dname=);
    proc print data=&dname;
    run;
%mend;

%print(dname=sashelp.class);
%print(dname=sashelp.cars);

/* Positional-parameter macro - subset by a (var,val) condition */
%macro sub(d=, r=, var=, val=);
    data &d;
        set &r;
        where &var = &val;
    run;

    proc print data=&d;
        title "Subset &d: &var=&val";
    run;
%mend;

%sub(d=class_M, r=sashelp.class, var=sex, val="M")
%sub(d=class_F, r=sashelp.class, var=sex, val="F")
