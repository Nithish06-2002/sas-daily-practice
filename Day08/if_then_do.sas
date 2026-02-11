* IF then else;

data park_type;
	set pg1.np_summary;
	if Type ="NM" then ParkType ="Monument";
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



*If then do;

data parks monuments;
    set pg1.np_summary;
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
