libname pg1 "/home/u64168920/EPG1V2/data" ;

/* proc sql inner joints */
proc sql;
select Season, Name, storm_summary.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary as u inner join pg1.storm_basincodes as v
		on  u.Basin=v.Basin
    order by Season desc, Name;
quit;
