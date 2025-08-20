* Encoding: UTF-8.
***********to update Women's Prison Population Decline Reflects Fewer Admissions to Prison graph in datawrapper*********
 *********CSV file WomenAdmissionPopulation***********

    
*******convert CURADMDT into date in 1989-2020 admissions file********
 
COMPUTE CURADMDT_month = TRUNC(CURADMDT / 1000000).
EXECUTE.

COMPUTE CURADMDT_day = TRUNC((CURADMDT - CURADMDT_month*1000000)/10000).
EXECUTE.

COMPUTE CURADMDT_year = CURADMDT - CURADMDT_month*1000000 - CURADMDT_day*10000.
EXECUTE.


COMPUTE CURADMDT_date = DATE.MDY(CURADMDT_month, CURADMDT_day, CURADMDT_year).
EXECUTE.

FORMATS CURADMDT_date (ADATE10).
VARIABLE LABELS CURADMDT_date "Converted Date from CURADMDT".
EXECUTE.

--- Numeric SFY ---

COMPUTE SFY = XDATE.YEAR(CURADMDT_date).
IF (XDATE.MONTH(CURADMDT_date) > 6) SFY = SFY + 1.
EXECUTE.

--- String SFY ---

STRING SFY_str (A8).
COMPUTE SFY_str = CONCAT("SFY", STRING(SFY, F4.0)).
VARIABLE LABELS SFY_str "State Fiscal Year (SFYYYYY)".
EXECUTE.
 
COMPUTE SFYEndDate = DATE.MDY(6,30,SFY).
execute.

**To get parole pop for 2010-2015 look in the annual reports 
    https://idoc.illinois.gov/reportsandstatistics/annualreports.html**
    

**********Exits Parole************
    
STRING MSRStatus (A20).
EXECUTE.

IF (NOT MISSING(ActualMandatorySupervisedReleaseMSRDate)) MSRStatus = "MSR Parole".
IF (MISSING(ActualMandatorySupervisedReleaseMSRDate)) MSRStatus = "Not MSR Parole".
EXECUTE.

*Years served including pretrial time ---> CustodyDate minus ExitDate, exclude MSR Violations*

COMPUTE CustodyDays = (ExitDate - CustodyDate) / (60*60*24).
execute.
COMPUTE CustodyYears_360 = (ExitDate - CustodyDate) / (60*60*24*360).
EXECUTE.



