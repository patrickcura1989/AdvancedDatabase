REM For demo purposes ONLY:
REM Select blocks to corrupt for scenario 2

set heading off
set pages 1000
set lines 81
set echo off
set verify off
set feedback off

spool dra2_setup2a.sh

SELECT 'dd of=C:/app/student/oradata/patrickcura/example01.dbf bs=8192 conv=notrunc seek=' || to_number(S.HEADER_BLOCK+1)|| ' << EOF',
'CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt ', 'EOF'
FROM V$DATAFILE D, DBA_SEGMENTS S
WHERE D.FILE#=S.HEADER_FILE
AND S.SEGMENT_NAME = 'REGIONS'
AND S.OWNER = 'HR';

spool off
spool dra2_setup2b.sh

SELECT 'dd of=C:/app/student/oradata/patrickcura/example01.dbf bs=8192 conv=notrunc seek=' || to_number(S.HEADER_BLOCK+1)|| ' << EOF',
'CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt ', 'EOF'
FROM V$DATAFILE D, DBA_SEGMENTS S
WHERE D.FILE#=S.HEADER_FILE
AND S.SEGMENT_NAME = 'EMPLOYEES'
AND S.OWNER = 'HR';

spool off

spool dra2_setup2c.sh

SELECT 'dd of=C:/app/student/oradata/patrickcura/example01.dbf bs=8192 conv=notrunc seek=' || to_number(S.HEADER_BLOCK+1)|| ' << EOF',
'CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt ', 'EOF'
FROM V$DATAFILE D, DBA_SEGMENTS S
WHERE D.FILE#=S.HEADER_FILE
AND S.SEGMENT_NAME = 'LOCATIONS'
AND S.OWNER = 'HR';

spool off
exit
