create table PURCHASEORDER_TEMP 
as 
select * 
  from PURCHASEORDER
/
drop table PURCHASEORDER
/
create table PURCHASEORDER 
             of XMLType
             XMLTYPE STORE as OBJECT RELATIONAL
             XMLSCHEMA "http://localhost:8080/source/schemas/poSource/xsd/purchaseOrder.xsd"
             Element "PurchaseOrder"
             PARTITION BY LIST (XMLDATA."CostCenter") (
               PARTITION P01 VALUES ('A0','A10','A20','A30'),
               PARTITION P02 VALUES ('A40','A50','A60','A70'),
               PARTITION P03 VALUES ('A80','A90','A100','A110')
             )
             PARALLEL 4
/
--
-- Rename the Nested Tables used to manage the collections of Action and LineItem elements
-- 
begin
  DBMS_XMLSTORAGE_MANAGE.renameCollectionTable(USER,'PURCHASEORDER',null,'/PurchaseOrder/Actions/Action/User','ACTION_TABLE',null);
  DBMS_XMLSTORAGE_MANAGE.renameCollectionTable(USER,'PURCHASEORDER',null,'/PurchaseOrder/LineItems/LineItem/Part','LINEITEM_TABLE',null);
end;
/
insert into PURCHASEORDER
select *
  from PURCHASEORDER_TEMP
/
drop table PURCHASEORDER_TEMP
/
create unique index "REFERENCE_INDEX" 
              on "PURCHASEORDER" ("SYS_NC00008$") 
/              
create index "USER_INDEX" 
       on "PURCHASEORDER" ("SYS_NC00019$") 
       Local
/
create index "PART_NUMBER_QUANTITY_INDEX" 
       on "LINEITEM_TABLE" ("SYS_NC00008$","Quantity") 
       Local
/
call Dbms_Stats.Gather_Schema_Stats(User)
/