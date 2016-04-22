create table PURCHASEORDER
          of XMLType
/
insert /*+ APPEND */ into PURCHASEORDER
select * 
  from DATA_STAGING_HOL
/
commit
/
call dbms_stats.gather_schema_stats(USER)
/
quit
