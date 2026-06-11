/* Day 08 - IF/THEN/ELSE and IF/THEN/DO patterns */
/* Inline park-summary-like dataset stands in for the original pg1.np_summary. */

data np_summary;
    length Reg $ 6 ParkName $ 24 Type $ 8;
    input Reg $ ParkName $ Type $ DayVisits OtherLodging TentCampers RVCampers BackcountryCampers;
    datalines;
IM    Yellowstone     NP    4257177  582300 100000 70000  4000
IM    GrandTeton      NP    3422024  216000  60000 35000  1500
PW    Yosemite        NP    4378963  214000 145000 25000  6000
SE    GreatSmoky      NP    14137812 195000  78000 15000  1200
NC    Acadia          NP    3537575  118000  37000  6000   850
SE    Everglades      NP    1162345   24000  19000  4000  1300
PW    JoshuaTree      NP    2986341       0  78000     0  3000
SE    BiscayneReef    NPRE    480222       0      0     0     0
SE    BigCypress      PRE     980321       0   8000     0   500
NE    DelawareWater   RVR    4123456       0  20000  3000     0
NE    BuffaloRiver    RIVERWAYS 1320000     0  18000  2000     0
NC    AssateagueIsl   NS    2450000  20000   45000  9000     0
PW    DevilsTower     NM      450000      0    1000     0     0
SE    FortFrederica   NM      125000      0       0     0     0
;
run;

/* IF/THEN/ELSE chains */
data park_type;
    set np_summary;
    if Type = "NM" then ParkType = "Monument";
    if Type = "NP" then ParkType = "Park";
    else if Type = "NPRE" or
            Type = "PRE" or
            Type = "PRESERVE"
             then ParkType = "Preserve";
    if Type = "NPRE" then ParkType = "Preserve";
    if Type = "NS" then ParkType = "Seashore";
    else if Type = "RVR" or
            Type = "RIVERWAYS"
         then ParkType = "River";
run;

proc print data=park_type;
run;

/* IF/THEN/DO with multi-output to two datasets */
data parks monuments;
    set np_summary;
    if Type in ("NP","NM");
    Campers = sum(TentCampers, RVCampers, BackcountryCampers);
    format Campers comma12.;
    if Type = "NP" then do;
        ParkType = "Park";
        output parks;
    end;
    else if Type = "NM" then do;
        ParkType = "Monument";
        output monuments;
    end;
    keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;

proc print data=parks;
    title "Parks";
run;

proc print data=monuments;
    title "Monuments";
run;
