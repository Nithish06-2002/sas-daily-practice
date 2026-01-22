/* view np_largeparks */
proc print data=pg1.np_largeparks;
run;

/* REMOVE THE DUPLICATES IN THE THABLE NP_LARGEPARKS
BY USING NODUPKEY SYNTAX ,AND SYNTAX DUPOUT GIVES DUPLICATE
ROWS WHICH HAS REMOVED FORM THE TABLE */
proc sort data=pg1.np_largeparks nodupkey out=park_clean dupout=park_dups;
	by _all_;
run;
