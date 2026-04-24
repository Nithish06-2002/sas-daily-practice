

/*	first.var and last.var	*/


Proc sort data=SAShelp.class out= sclass;
By Age;
run;

Proc print;run;
/*

Age  First.age	Last.age
11		1			0
11		0			1
12		1			0
12		0			0
12		0			0
12		0			0
12		0			1
13		1			0
13		0			0
13		0			1
14		1			0
14		0			0
14		0			0
14		0			1
15		1			0
15		0			0
15		0			0
15		0			1
16		1			1


;
/*First occerance*/

Data Sclass1;
set Sclass;
By Age;
If first.age=1;
Run;

Proc Print; Run;
/*last occerance*/

Data Sclass2;
set Sclass;
By age;
If last.age=1;
Run;
Proc Print ; Run;
/*Unique Occerance*/

Data Sclass3;
set Sclass;
By age;
If First.age=1 and last.age=1;
Run;

Proc Print; run;

/*No. of occerance*/
Data Sclass4;
set Sclass;
By age;
If First.age=1 Then Count =1;
else Count+1; 
Run;
Proc Print ; Run;
/*Selective occerance*/

Data Sclass5;
set Sclass;
By age;
If First.age=1 Then Count =1;
else Count+1; 

If count=3;
Run;

Proc Print ; run;


/*Freqency dataset according to Age*/

Data Sclass5 (Keep=Age Count);
set Sclass;
By age;
If First.age=1 Then Count =1;
else Count+1; 

If LAST.age=1;
Run;

Proc Print ; run;

Proc Sort data=SAShelp.class Out=Class;
By sex;
Run;


/*Freqency dataset according to Sex*/

Data Sclass8 (Keep=Sex Count);
set class;
By Sex;
If First.sex=1 Then Count =1;
else Count+1; 

If Last.Sex=1;
Run;

Proc Print ; run;

