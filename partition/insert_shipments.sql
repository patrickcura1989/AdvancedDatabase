REM RUDIMENTARY PARTITIONING OBE
REM
REM v0.1
REM
REM mwiel	10/18/06	- initial creation
REM hbaer	02/07/07	- first adjustments and extensions
REM
set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85

REM New extended composite partitions
REM 1.Recap the concept of composite partitioned tables
REM 2.Introduce the new extension based on business cases (e.g. RANGE-RANGE on oder_date/ship_date
REM 3.Demonstrate the data placement for a business scenario
REM 

REM
REM EXTENDED COMPOSITE PARTITIONING
REM

set echo on
-- insert some data into the shipments table

insert into shipments select o.order_id
, to_date('12-oct-2006','dd-mon-yyyy')
, to_date('12-oct-2006','dd-mon-yyyy') + trunc(70 * abs(dbms_random.value))  -- generate some early, agreed, late orders
, nvl(o.sales_rep_id,trunc(105 * dbms_random.value))
, sum(oi.unit_price * oi.quantity)
from oe.orders o
, oe.order_items oi
where o.order_id = oi.order_id
group by o.order_id
, o.sales_rep_id
/

commit
/
