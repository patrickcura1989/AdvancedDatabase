OPTIONS (DIRECT=TRUE)
load data
infile '2010.dat'
append
into table PURCHASEORDER
xmltype(XMLDATA) (
 filename filler char(120),
 XMLDATA  lobfile(filename) terminated by eof)

