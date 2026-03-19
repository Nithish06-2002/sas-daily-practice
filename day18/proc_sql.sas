*Syntax

Proc sql;
Select column(s)
From table 
Where expression
Group by column
Having expression
Order by column
Quit;

Proc sql;
Create table nithish(name char(20) ,age num , gender char(10));
Insert into nithish
Values("Nithi",23,"Male")
Values("Gagana",21,"Female");
Quit;


/* Set statement can be used instead of value */

Proc sql;
Create table nithish (name char(20) ,age num ,gender char(10));
Insert into nithish
Set name="Nithi",age=23,gender="Male"
Set name="Gagana",age=21,gender="Female" ;
Quit;

/* To print the dataset In the output window use (create table) */
Proc sql;
Create table class as select * from sashelp.class;
Quit;

/* If only using select statment It will print in result window */
Proc sql;
select Name,age ,height from sashelp.class;
Quit;

/* Use feedback to get the the detailed structure in log window */
Proc sql feedback;
select Name,age ,height from sashelp.class;
Quit;

/* To print limited observations the result window use(outobs) */
proc sql OUTOBS=10;
SELECT *FROM SASHELP.CLASS;
QUIT;

/* Rename variable by using (AS) */
Proc sql feedback;
select Name AS STUDENT_NAME,age,Sex as Gender ,height from sashelp.class;
Quit;

/* Create a new variable */
proc sql;
Select *,(weight*0.45) as wt_kg from sashelp.class;
quit;

/* distinct used to remove duplicate */
proc sql;
select distinct * from class;
quit;

/* label function */
Proc sql feedback;
select Name label="STUDENT_NAME",age,Sex label= "Gender" ,height from sashelp.class;
Quit;

Proc sql feedback;
select Name label="STUDENT_NAME",age format=dollor4.,Sex label= "Gender" ,height from sashelp.class;
Quit;

/* order by to sort the data */
proc sql;
select  * from sashelp.class order by sex,age;
quit;

proc sql;
select  * from sashelp.class order by sex desc,age desc;
quit;

/* where */
proc sql;
select  * from sashelp.class where sex="F";
quit;

/* in */
proc sql;
select  * from sashelp.class where age in(15,16);
quit;

proc sql ;
select * from sashelp.class where age>12 and age<16;
quit;

/* between */
proc sql ;
select * from sashelp.class where age between 12 and 13;
quit;

/* like */
proc sql;
select *from sashelp.class where name like "A%";
quit;

/* contains */
proc sql;
select *from sashelp.class where name contains "Will";
quit;
