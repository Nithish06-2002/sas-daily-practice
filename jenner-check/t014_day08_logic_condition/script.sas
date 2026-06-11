/* Day 08 - IF/THEN/ELSE chain to assign Ocean from Basin code */
/* Inline storm_summary stand-in with the same Basin/Season/Name/MaxWindMPH columns. */

data storm_summary;
    length Basin $ 4 Name $ 14;
    input Basin $ Season Name $ MaxWindMPH;
    datalines;
NA  2017 Harvey   132
NA  2017 Irma     177
NA  2018 Florence 138
EP  2018 Walaka   161
WP  2017 Lan      109
WP  2018 Mangkhut 178
NI  2017 Mora      75
SI  2018 Cebile   161
SI  2017 Enawo    149
SP  2018 Gita     132
SP  2017 Donna    109
NA  2019 Dorian   184
EP  2019 Lorena   85
WP  2019 Hagibis  161
SI  2019 Idai     132
;
run;

data storm_summary2;
    set storm_summary;
    Length Ocean $ 20;
    keep Basin Season Name MaxWindMPH Ocean OceanCode;
    Basin = upcase(Basin);
    OceanCode = substr(Basin, 2, 1);
    if OceanCode = "I" then Ocean = "Indian";
    else if OceanCode = "A" then Ocean = "Atlantic";
    else Ocean = "Pacific";
run;

proc print data=storm_summary2;
    title "Basin -> Ocean derivation";
run;
