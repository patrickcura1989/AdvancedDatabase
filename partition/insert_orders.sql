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

REM 
REM REF Partitioning
REM 5.insert data into orders. Show data placement in an explicit partition
REM 

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85

-- insert some data into the orders and order_items tables


insert into orders values (1, to_date('23-OCT-2006','dd-MON-yyyy'), 'manual', 'U') ;
insert into orders values (2, to_date('24-OCT-2006','dd-MON-yyyy'), 'auto', 'I') ;
insert into orders values (3, to_date('25-OCT-2006','dd-MON-yyyy'), 'manual', 'P') ;
insert into orders values (4, to_date('26-OCT-2006','dd-MON-yyyy'), 'manual', 'U') ;
insert into orders values (5, to_date('26-NOV-2006','dd-MON-yyyy'), 'manual', 'U') ;
insert into order_items values (1, 12, 40, 12000) ;
insert into order_items values (1, 2, 1, 2000) ;
insert into order_items values (1, 8, 20, 8400) ;
insert into order_items values (2, 1, 4, 900) ;
insert into order_items values (2, 87, 4, 6200) ;
insert into order_items values (2, 2, 4, 3400) ;
insert into order_items values (2, 6, 2, 70) ;
insert into order_items values (3, 1, 90, 1200) ;
insert into order_items values (4, 90, 10, 9000) ;
insert into order_items values (4, 74, 12, 8000) ;
insert into order_items values (4, 21, 1, 900) ;
insert into order_items values (4, 90, 4, 39000) ;
insert into order_items values (4, 32, 6, 700) ;
insert into order_items values (4, 45, 2, 80) ;
insert into order_items values (4, 72, 6, 72000) ;
insert into order_items values (5, 1, 40, 42000) ;
insert into order_items values (5, 2, 40, 800) ;
insert into order_items values (5, 52, 80, 100) ;
insert into order_items values (5, 90, 4, 1200) ;

commit
/

