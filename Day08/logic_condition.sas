/* if then else */

data storm_summary2;
	set pg1.storm_summary;
	Length Ocean $ 20;
	keep Basin Season Name MaxWindMPH Ocean OceanCode;
	Basin = upcase(Basin);
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then Ocean="Indian";
	else if OceanCode="A" then Ocean="Atlantic";
	else Ocean="Pacific";
run;


/* if then else */

data storm_summary2;
	set pg1.storm_summary;
	
	keep Basin Season Name MaxWindMPH Ocean OceanCode;
	Basin = upcase(Basin);
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then Ocean="Indian";
	else if OceanCode="A" then Ocean="Atlantic";
	else Ocean="Pacific";
	Length Ocean $ 20;
run;
