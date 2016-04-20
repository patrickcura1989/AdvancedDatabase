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
REM 6.insert data into the REF partitioned table and show that co-location of  the dependent data is taken place
REM 

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
set echo on
set feedback on

-- manageability aspects and flexibility to combine PMOPs but still have the flexibility to place various partitions

alter table orders 
add partition p2007_01 values less than (to_date('01-feb-2007','dd-mon-yyyy')) 
tablespace x;

-- show co-location of partitions for parent and child

select table_name, partition_name, tablespace_name, high_value 
from user_tab_partitions where table_name in ('ORDERS','ORDER_ITEMS') 
order by partition_position, table_name;

-- second PMOP

alter table orders 
add partition p2007_02 values less than (to_date('01-mar-2007','dd-mon-yyyy')) 
tablespace x
dependent tables ( order_items (partition foo tablespace y));

select table_name, partition_name, tablespace_name, high_value 
from user_tab_partitions 
where table_name in ('ORDERS','ORDER_ITEMS') order by partition_position, table_name;

