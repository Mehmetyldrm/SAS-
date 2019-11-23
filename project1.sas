LIBNAME a "C:\Users\memosz\Documents\Classes\3.Semester\EHA individual\EHA_individual\projects\project_1_nonparametric\data";
/**********************************/
/*********Impoting Data***********/
/********************************/
proc import out= work.data
datafile='C:\Users\memosz\Documents\Classes\3.Semester\EHA individual\EHA_individual\projects\project_1_nonparametric\data\medpar.csv'
dbms=csv replace; getnames=yes; datarow=2;
run;

/***********************************************/
/*Conduct univariate analysis of time to event*/
/*********************************************/

proc univariate data=data;
var los;
histogram los / normal kernel;
inset mean std n / position=ne;
probplot los / normal(mu=est sigma=est);
inset mean std n / position=nw; 
run;



proc univariate data = proj1.data;
var los;
inset mean std n / position=ne;
histogram los / kernel;
run;
/************************************/
/*********Producing K-M plot********/
/***********First Method***********/
/*********************************/

/*ods graphics on;
proc lifetest data=proj1.data  method=km;
time los*died(0);
run;
ods graphics off;*/

proc lifetest data=data method=km plots=(survival) ;
 time los*died(0);
 id hmo white age80 type;
run; 

/**********************************/
/**********Second Method**********/
/********************************/

ods graphics on;
proc lifetest data=data method=km plots=(s) intervals=(0 to 21 by 7);
time los*died(0);
symbol1 v=none;
run;
ods graphics off;

/*******************************/
/**signifacancy of variable****/
/*****************************/

proc lifetest data=data method=km plots=(s);
time los*died(0);
test hmo white age80 ;
run;
