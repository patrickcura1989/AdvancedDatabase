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
REM 1.Introduce the concept of REF Partitioning
REM 2.Create a simple partitioned table (e.g. Orders, partitioned by order_date, PK order_id)

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85

-- cleanup

drop table order_items
/

drop table orders
/


-- create initial tablespaces 

drop tablespace x;
create tablespace x datafile './x.f' size 10m reuse;

drop tablespace y;
create tablespace y datafile './y.f' size 10m reuse;

-- create a range-partitioned table orders


create table orders
( order_id number(12) not null
, order_date date not null
, order_mode varchar2(8)
, order_status varchar2(1)
)
partition by range (order_date)
( partition p_before_jan_2006 values less than (to_date('01-JAN-2006','dd-MON-yyyy'))
, partition p_2006_jan values less than (to_date('01-FEB-2006','dd-MON-yyyy'))
, partition p_2006_feb values less than (to_date('01-MAR-2006','dd-MON-yyyy'))
, partition p_2006_mar values less than (to_date('01-APR-2006','dd-MON-yyyy'))
, partition p_2006_apr values less than (to_date('01-MAY-2006','dd-MON-yyyy'))
, partition p_2006_may values less than (to_date('01-JUN-2006','dd-MON-yyyy'))
, partition p_2006_jun values less than (to_date('01-JUL-2006','dd-MON-yyyy'))
, partition p_2006_jul values less than (to_date('01-AUG-2006','dd-MON-yyyy'))
, partition p_2006_aug values less than (to_date('01-SEP-2006','dd-MON-yyyy'))
, partition p_2006_sep values less than (to_date('01-OCT-2006','dd-MON-yyyy'))
, partition p_2006_oct values less than (to_date('01-NOV-2006','dd-MON-yyyy'))
, partition p_2006_nov values less than (to_date('01-DEC-2006','dd-MON-yyyy'))
, partition p_2006_dec values less than (to_date('01-JAN-2007','dd-MON-yyyy'))
) parallel
/

alter table orders add constraint orders_pk
primary key (order_id)
/

