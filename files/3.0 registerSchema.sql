declare
  cursor getTable
  is
  select TABLE_NAME
    from USER_XML_TABLES
   where TABLE_NAME in ( 'PURCHASEORDER');
begin
  for t in getTable() loop
    execute immediate 'DROP TABLE "' || t.TABLE_NAME || '" PURGE';
  end loop;
end;
/
declare
  V_XML_SCHEMA xmlType := xdburitype('/home/OE/PurchaseOrder.xsd').getXML();
begin
  DBMS_XMLSCHEMA_ANNOTATE.disableMaintainDOM(V_XML_SCHEMA);
  DBMS_XMLSCHEMA_ANNOTATE.setDefaultTable(V_XML_SCHEMA,'PurchaseOrder','PURCHASEORDER');
  DBMS_XMLSCHEMA_ANNOTATE.setSQLType(V_XML_SCHEMA,'PurchaseOrderType','PURCHASEORDER_T');
  DBMS_XMLSCHEMA_ANNOTATE.setSQLType(V_XML_SCHEMA,'LineItemType','LINEITEM_T');
  DBMS_XMLSCHEMA_ANNOTATE.setSQLCollType(V_XML_SCHEMA,'LineItem','LINEITEM_V');
  DBMS_XMLSCHEMA_ANNOTATE.setSQLType(V_XML_SCHEMA,DBMS_XDB_CONSTANTS.XSD_COMPLEX_TYPE,'ActionsType',DBMS_XDB_CONSTANTS.XSD_ELEMENT,'Action','ACTION_T');
  DBMS_XMLSCHEMA_ANNOTATE.setSQLCollType(V_XML_SCHEMA,'Action','ACTION_V');
  DBMS_XMLSCHEMA_ANNOTATE.setSqlType(V_XML_SCHEMA,DBMS_XDB_CONSTANTS.XSD_COMPLEX_TYPE,'PurchaseOrderType',DBMS_XDB_CONSTANTS.XSD_ELEMENT,'CostCenter','VARCHAR2');
  DBMS_XMLSCHEMA.registerSchema
  (
    SCHEMAURL        => 'http://localhost:8080/source/schemas/poSource/xsd/purchaseOrder.xsd', 
    SCHEMADOC        => V_XML_SCHEMA,
    LOCAL            => TRUE,
    GENBEAN          => FALSE,
    GENTYPES         => TRUE,
    GENTABLES        => TRUE,
    ENABLEHIERARCHY  => DBMS_XMLSCHEMA.ENABLE_HIERARCHY_NONE
  );
end;
/  
desc PURCHASEORDER
--
desc PURCHASEORDER_T
--
select table_name
  from USER_NESTED_TABLES
 where PARENT_TABLE_NAME = 'PURCHASEORDER'
/
-- Rename the Nested Tables used to manage the collections of Action and LineItem elements
-- 
begin
  DBMS_XMLSTORAGE_MANAGE.renameCollectionTable(USER,'PURCHASEORDER',null,'/PurchaseOrder/Actions/Action/User','ACTION_TABLE',null);
  DBMS_XMLSTORAGE_MANAGE.renameCollectionTable(USER,'PURCHASEORDER',null,'/PurchaseOrder/LineItems/LineItem/Part','LINEITEM_TABLE',null);
end;
/
