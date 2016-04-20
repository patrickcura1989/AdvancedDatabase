alter user sh identified by sh account unlock;
grant create tablespace to sh;
grant drop tablespace to sh;
alter user hr identified by hr account unlock;
alter user oe identified by oe account unlock;
grant select on oe.orders to sh;
grant select on oe.order_items to sh;
grant select on hr.employees to sh;