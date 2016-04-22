--
--  Create an Unique Index on /PurchaseOrder/Reference
-- 
SELECT 'create unique index "REFERENCE_INDEX" on "' || i.TARGET_TABLE_NAME || '" ("' || i.TARGET_COLUMN_NAME || '");' REFERENCE_INDEX
  from XMLTable(
         '/Result/Mapping'
         passing DBMS_XMLSTORAGE_MANAGE.XPATH2TABCOLMAPPING(USER,'PURCHASEORDER',NULL,'/PurchaseOrder/Reference','')
         COLUMNS
           TARGET_TABLE_NAME   VARCHAR2(30) path '@TableName',
           TARGET_COLUMN_NAME  VARCHAR2(30) path '@ColumnName'
        ) i
/
--
--  Create an Non-Unique Index on /PurchaseOrder/Requestor
-- 
SELECT 'create index "USER_INDEX" on "' || i.TARGET_TABLE_NAME || '" ("' || i.TARGET_COLUMN_NAME || '");' USER_INDEX
  from XMLTable(
          '/Result/Mapping'
           passing DBMS_XMLSTORAGE_MANAGE.XPATH2TABCOLMAPPING(USER,'PURCHASEORDER',NULL,'/PurchaseOrder/User','')
           COLUMNS
           TARGET_TABLE_NAME   VARCHAR2(30) path '@TableName',
           TARGET_COLUMN_NAME  VARCHAR2(30) path '@ColumnName'
        ) i
/
--  Create an Non-Unique Composite Index on /PurchaseOrder/LineItems/LineItem/Part/text() and /PurchaseOrder/LineItems/LineItem/Quantity
-- 
SELECT 'create index "PART_NUMBER_QUANTITY_INDEX" on "' || i.TARGET_TABLE_NAME || '" ("' || i.TARGET_COLUMN_NAME || '","' || j.TARGET_COLUMN_NAME || '");' PART_NUMBER_QUANTITY_INDEX
  from XMLTable(
         '/Result/Mapping'
         passing DBMS_XMLSTORAGE_MANAGE.XPATH2TABCOLMAPPING(USER,'PURCHASEORDER',NULL,'/PurchaseOrder/LineItems/LineItem/Part','')
         COLUMNS
         TARGET_TABLE_NAME   VARCHAR2(30) path '@TableName',
         TARGET_COLUMN_NAME  VARCHAR2(30) path '@ColumnName'
       ) i,
       XMLTable(
          '/Result/Mapping'
          passing DBMS_XMLSTORAGE_MANAGE.XPATH2TABCOLMAPPING(USER,'PURCHASEORDER',NULL,'/PurchaseOrder/LineItems/LineItem/Quantity','')
          COLUMNS
          TARGET_TABLE_NAME   VARCHAR2(30) path '@TableName',
          TARGET_COLUMN_NAME  VARCHAR2(30) path '@ColumnName'
       ) j
/        
select 'call dbms_stats.gather_schema_stats(USER);' from dual
/


