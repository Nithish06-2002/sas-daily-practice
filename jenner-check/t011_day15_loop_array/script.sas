/* Day 15 - DO loops and ARRAY basics */

/* DO loop with BY step */
DATA J;
    DO i = 1 TO 10 by 3;
        OUTPUT;
    END;
RUN;

proc print data=J;
run;

/* Visit counter */
DATA visits;
    DO VISIT = 1 TO 5;
        OUTPUT;
    END;
RUN;

proc print data=visits;
run;

/* Array filling: visit{i} = i + 5 */
data visit_array;
    array visit{5} visit1 visit2 visit3 visit4 visit5;
    do i = 1 to 5;
        visit{i} = i + 5;
    end;
run;

proc print data=visit_array;
run;

/* Array with output per iteration */
DATA L;
    array x(3) x1 x2 x3;
    do i = 1 to 3;
        x(i) = 5;
        if x(i) = . then x(i) = 0;
        output;
    end;
run;

proc print data=L;
run;
