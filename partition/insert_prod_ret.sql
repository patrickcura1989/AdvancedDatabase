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
REM Virtual column-based partitioning
REM 1.Introduce the concept of a virtual column (e.g. Extract the month out of a date)
REM 2.Create a simple virtual column and select from it (you can also highlight that you can collect stats on such a column)
REM 3.Create a virtual column-based partitioned table (for demonstration purposes this can be something goofy like adding two column values or so)
REM 4.insert some data and show the data placement based on the virtual column definitions
REM 

set echo on
-- insert some data into the table


set feedback off

insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1, 36, 109, 10, 120) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (2, 46, 129, 20, 10) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (3, 73, 159, 15, 1) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (4,136,1109, 16, 2) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (5, 27, 309, 20, 420) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (6, 96, 129, 10, 1020) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (7, 39, 104, 1, 12000) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (8,436,6109, 8, 200) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (9,789, 709, 2, 2400) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (11,276, 809,9, 10000) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (12, 34, 199, 10, 20000) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (15, 24, 100,5, 10) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (17, 76,1109, 1, 20) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (19, 55, 209, 1, 300000) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (21, 76, 139, 1, 10) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (31, 90, 104, 2, 4020) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (51,284,5109, 9, 60) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1,912, 169, 1, 10980) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (31,536, 179, 2, 60) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (13,752, 108, 1, 400) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (12,986,1109, 3, 700) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1, 39, 129, 4, 6) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1, 32, 103, 1, 30) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (12, 34, 104, 1, 98710) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1,173,6109, 1, 9650) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (17,853,7109, 1, 60) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (19,981, 809, 5, 80) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1, 84, 103, 16, 1000) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1, 21,2109, 1000, 90) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (13,782,2359, 102, 1850) ;
insert into product_returns (order_id, product_id, customer_id, quantity, unit_price) values (1,941,5309, 10, 40) ;
commit ;

