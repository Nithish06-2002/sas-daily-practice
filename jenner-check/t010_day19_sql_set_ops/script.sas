/* Day 19 - PROC SQL set operators (UNION ALL and INTERSECT) */
/* Three small inline tables built from DATALINES. */

data patients;
    input Patient_ID Name $ Age Gender $;
cards;
101 John 45 M
102 Alice 38 F
103 Bob 50 M
104 Mary 29 F
105 David 60 M
;
run;

data treatment;
    input Patient_ID Drug $ Dose;
cards;
101 DrugA 10
102 DrugB 20
103 DrugA 15
104 DrugC 10
105 DrugB 25
;
run;

data adverse;
    input Patient_ID AE_Term $ Severity $;
cards;
101 Headache Mild
101 Nausea Moderate
102 Fever Mild
103 Headache Severe
104 Vomiting Moderate
105 Fever Mild
;
run;

/* UNION ALL stacks both tables (no dedup) */
PROC SQL;
    SELECT * FROM patients
    UNION ALL
    SELECT * FROM treatment;
QUIT;

/* INTERSECT returns Patient_IDs in both tables */
PROC SQL;
    SELECT Patient_ID FROM patients
    INTERSECT
    SELECT Patient_ID FROM treatment;
QUIT;

/* EXCEPT returns Patient_IDs in patients but not treatment */
PROC SQL;
    SELECT Patient_ID FROM patients
    EXCEPT
    SELECT Patient_ID FROM adverse;
QUIT;
