OPTIONS (DIRECT=TRUE)
load data
infile '../sampleData/2010.dat'
append
into table DATA_STAGING_HOL
xmltype(XMLDATA) (
 filename filler char(120),
 XMLDATA  lobfile(filename) terminated by eof)

