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
set echo on

set feedback on

-- see how the data was co-located in the same partitions

alter session set nls_date_format='dd-mon-yyyy' ;

select order_id, order_date
from orders partition (p_2006_oct)
/


select oi.order_id, o.order_date, sum(oi.sales_amount) sum_sales
from orders o
, order_items partition (p_2006_oct) oi
where o.order_id = oi.order_id
group by oi.order_id, o.order_date
order by oi.order_id
/


select order_id, order_date
from orders partition (p_2006_nov)
/


select oi.order_id, o.order_date, sum(oi.sales_amount) sum_sales
from orders o
, order_items partition (p_2006_nov) oi
where o.order_id = oi.order_id
group by oi.order_id, o.order_date
order by oi.order_id
/

