/* data prepration  */

data patients_raw;
    input PatID $ Name $20. Gender $ City $20.
          Drug $15. Batch $10.;
    datalines;
P001 john_miller M hyderabad Paracetamol B#101
P002 SARAH_JOHNSON F mumbai Amoxicillin B#102
P003 rAj_kUmAr M delhi Ibuprofen B#103
P004 Meena_Shah F chennai Cetirizine B#104
P005 david_lee M bangalore Azithromycin B#105
;
run;



data patients_clean;
    set pharma.patients_raw;

    Drug_Upper     = upcase(Drug);
    City_Lower     = lowcase(City);
    Name_Proper    = propcase(Name);
    Name_Length    = length(Name);

    Pat_Batch      = cat(PatID, Batch);
    Subject_Label  = catx("-", PatID, Gender, City);

    Batch_Clean    = compress(Batch, "#");
    Name_NoSpace   = compress(Name);

    Name_Space     = translate(Name, " ", "_");
    Drug_Short     = tranwrd(Drug, "Paracetamol", "PCM");

    Name_Strip     = strip(Name);
    Name_Trim      = trim(Name);
run;
