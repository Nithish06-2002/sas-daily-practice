/* INPUT FILE */

DATA NITHI.N;
INFILE "C:\Users\nithi\OneDrive\Desktop\New folder\NITHISH---21--2000.txt"
DLM="-" DSD;
INPUT NAME $ AGE SCORE;
RUN;


/* CHARACTER FUNCTIONS */

/* CASE + LENGTH */

DATA B;
C = "NithIsh FireT Class";

M = UPCASE(C);
N = LOWCASE(C);
O = PROPCASE(C);
P = LENGTH(C);
RUN;


/* CAT */

DATA C;
X = "nithi";
Y = "is";
Z = "a good boy";

A = CAT(X,Y,Z);
RUN;


/* PIPE CONCATENATION */

DATA D;
X = "nithi";
Y = "is";
Z = "a good boy";

A = X||Y||Z;
RUN;


/* COMPRESS — REMOVE BLANKS */

DATA G;
L = "N  i th                  i  sh";
M = COMPRESS(L);
RUN;


/* COMPRESS — REMOVE SPECIAL CHAR */

DATA H;
M = "nithishshivai$%#ah";
N = COMPRESS(M,"$%#");
RUN;


/* COMPBL — MULTIPLE BLANK → SINGLE */

DATA K;
L = "there    is a    good tree";
A = COMPBL(L);
RUN;


/* TRANSLATE */

DATA J;
K = "kitdigh";
L = TRANSLATE(K,"NHS","kdg");
RUN;


/* TRANWRD */

DATA P;
Q = "nithish";
T = TRANWRD(Q,"nithish","pharmaxene");
RUN;


/* SET — EXISTING DATASET */

DATA NEW;
SET SASHELP.CLASS;

UP = UPCASE(NAME);
LO = LOWCASE(NAME);
PR = PROPCASE(NAME);
LE = LENGTH(NAME);
CT = CAT(NAME,SEX);
TR = TRANWRD(NAME,"Judy","Nithish");
RUN;
