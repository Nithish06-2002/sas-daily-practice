/* Day 19 - SELECT/WHEN/OTHERWISE example on sashelp.class */
/* Maps AGE values to a small ordinal NEWVAR. */

DATA SL;
    SET SASHELP.CLASS;
    SELECT (AGE);
        WHEN (13) NEWVAR=1;
        WHEN (14) NEWVAR=2;
        WHEN (15) NEWVAR=3;
        WHEN (16) NEWVAR=4;
        OTHERWISE NEWVAR=.;
    END;
RUN;

proc print data=sl;
run;
