sqlplus system/$1 @reset_XMLDB_HOL.sql OE $2 \"$PWD\"
sqlldr -userid=OE/$2 -control=../sampleData/2010.ctl -log=reload_XMLDB_DATA.log

