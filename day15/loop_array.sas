/* LOOP */
DATA J;
DO i=1 TO 10 by 3;
OUTPUT;
END;
RUN;

/* EXAMPLE */
DATA K;
DO VISIT= 1 TO 5;
OUTPUT;
END;
RUN;

/* ARRAY */
*An ARRAY in SAS is simply a way to work with many similar variables using one loop, 
instead of writing the same code again and again.;

/* GENERAL SYNTAX OF ARRY--->ARRAY array_name{number_of_elements} variable1 variable2 variable3 ...; */

data K;
array visit{5} visit1 visit2 visit3 visit4 visit5;
do i=1 to 5;
   visit{i}=i+5;
end;
run;

/* EXAMPLE2 */

DATA L;
array x(3) x1 x2 x3;
do i=1 to 3;
x(i) =5;
if x(i)=. then x(i)=0;
output;
end;
run;

DATA L;
array x(3) x1 x2 x3;
do i=1 to 3;
x(i) =5;
end;
run;

DATA L;
array x(3) x1 x2 x3;
do i=1 to 3;
if x(i)=. then x(i)=0;
output;
end;
run;
