/* do loop  */

do loop can execute any number of times in a single iteration of data
step

concise
easier to change and debug ;

three types
1) DO
2) DO WHILE 
3) DO UNTIL

/* ITERATIVE DO LOOPS */;

DATA ACCOUNT;
BALANCE = 2000;
DO i = 1 to 6;
BALANCE + 1000;
drop i;
output;
end;
run;

data earning;
amount = 1000;
rate =5;
earned = 0;
do i = 1 to 12;
earned = earned + (amount+earned) *5/100;
output;
end;
run;

data balance;
amount = 10000;
do payment_number=1 to 10;
amount=amount-1000;
output;
end;
run;
