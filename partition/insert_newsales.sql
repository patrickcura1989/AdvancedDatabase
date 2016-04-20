set echo off
REM RUDIMENTARY PARTITIONING OBE
REM
REM v0.1
REM
REM mwiel	10/18/06	- initial creation
REM hbaer	02/07/07	- first adjustments and extensions
REM
REM
REM
REM
set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
REM
REM Interval Partitioning
REM 4.Insert new data that forces the creation of a new partition (segment)
set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
-- insert some data after January 1 2005

insert into newsales values (11160,17450,to_date('01-jan-2005','dd-mon-yyyy'),'I',9999,19,798) ;
insert into newsales values (1340,33710,to_date('02-jan-2005','dd-mon-yyyy'),'S',9999,16,1264) ;
insert into newsales values (25270,65880,to_date('05-jan-2005','dd-mon-yyyy'),'I',9999,5,210) ;
insert into newsales values (1615,73480,to_date('05-jan-2005','dd-mon-yyyy'),'I',9999,8,96) ;
insert into newsales values (1900,84910,to_date('06-jan-2005','dd-mon-yyyy'),'I',9999,42,378) ;
insert into newsales values (8085,37900,to_date('09-jan-2005','dd-mon-yyyy'),'S',9999,1,68) ;
insert into newsales values (755,26590,to_date('09-jan-2005','dd-mon-yyyy'),'I',9999,11,132) ;
insert into newsales values (10,68060,to_date('09-jan-2005','dd-mon-yyyy'),'P',9999,28,4900) ;
insert into newsales values (13425,109310,to_date('10-jan-2005','dd-mon-yyyy'),'I',9999,1,68) ;
insert into newsales values (1955,65190,to_date('10-jan-2005','dd-mon-yyyy'),'S',9999,28,1512) ;

set feedback on

commit
/

