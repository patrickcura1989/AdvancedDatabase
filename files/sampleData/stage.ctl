OPTIONS (DIRECT=TRUE)
load data
infile 'C:\xdb\Demo\11.2.0.1.0\HOL-2011\LOCAL\SampleData\2010.dat'
append
into table DATA_STAGING_OTN 
xmltype(XMLDATA) (
 filename filler char(120),
 XMLDATA  lobfile(filename) terminated by eof)

