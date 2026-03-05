/*------------------------------------------------*/
/* GENERAL SYNTAX OF COMMON SAS PROC PROCEDURES   */
/*------------------------------------------------*/


/* PROC MEANS */

PROC MEANS DATA=dataset options;
    VAR variable1 variable2;
    CLASS variable;
    BY variable;
    OUTPUT OUT=new_dataset statistics;
RUN;

PROC MEANS DATA=sashelp.class MEAN MEDIAN STD;
    VAR height weight;
RUN;


/*------------------------------------------------*/
/* PROC FREQ */
/*------------------------------------------------*/

PROC FREQ DATA=dataset;
    TABLES variable1 variable2 / options;
    BY variable;
    WEIGHT variable;
RUN;

PROC FREQ DATA=sashelp.class;
    TABLES sex;
RUN;


/*------------------------------------------------*/
/* PROC PRINT */
/*------------------------------------------------*/

PROC PRINT DATA=dataset options;
    VAR variable1 variable2;
    BY variable;
    WHERE condition;
    ID variable;
RUN;

PROC PRINT DATA=sashelp.class;
    VAR name age height;
RUN;


/*------------------------------------------------*/
/* PROC COMPARE */
/*------------------------------------------------*/

PROC COMPARE BASE=dataset1 COMPARE=dataset2 options;
    VAR variable-list;
    ID variable;
RUN;

PROC COMPARE BASE=a COMPARE=b;
RUN;


/*------------------------------------------------*/
/* PROC CONTENTS */
/*------------------------------------------------*/

PROC CONTENTS DATA=dataset options;
RUN;

PROC CONTENTS DATA=sashelp.class;
RUN;


/*------------------------------------------------*/
/* PROC GCHART */
/*------------------------------------------------*/

PROC GCHART DATA=dataset;
    VBAR variable;
    HBAR variable;
    PIE variable;
RUN;
QUIT;

PROC GCHART DATA=sashelp.class;
    VBAR sex;
RUN;
QUIT;


/*------------------------------------------------*/
/* PROC SUMMARY */
/*------------------------------------------------*/

PROC SUMMARY DATA=dataset options;
    CLASS variable;
    VAR variable-list;
    OUTPUT OUT=new_dataset statistics;
RUN;

PROC SUMMARY DATA=sashelp.class;
    VAR height weight;
    OUTPUT OUT=result MEAN=;
RUN;


/*------------------------------------------------*/
/* PROC TABULATE */
/*------------------------------------------------*/

PROC TABULATE DATA=dataset;
    CLASS variable;
    VAR variable;
    TABLE row-variable , column-variable*statistic;
RUN;

PROC TABULATE DATA=sashelp.class;
    CLASS sex;
    VAR height;
    TABLE sex , height*mean;
RUN;


/*------------------------------------------------*/
/* PROC TTEST */
/*------------------------------------------------*/

PROC TTEST DATA=dataset options;
    CLASS grouping_variable;
    VAR numeric_variable;
    BY variable;
RUN;

PROC TTEST DATA=sashelp.class;
    CLASS sex;
    VAR height;
RUN;


/*------------------------------------------------*/
/* PROC ANOVA */
/*------------------------------------------------*/

PROC ANOVA DATA=dataset;
    CLASS variable;
    MODEL dependent_variable = independent_variable;
    MEANS variable;
RUN;
QUIT;

PROC ANOVA DATA=sashelp.class;
    CLASS sex;
    MODEL weight = sex;
RUN;
QUIT;


/*------------------------------------------------*/
/* PROC SQL */
/*------------------------------------------------*/

PROC SQL;
    SELECT column1, column2
    FROM dataset
    WHERE condition
    GROUP BY column
    ORDER BY column;
QUIT;

PROC SQL;
    SELECT name, age
    FROM sashelp.class
    WHERE age > 13;
QUIT;
