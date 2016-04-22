set echo on
spool reset_XMLDB_HOL.log
--
def USERNAME = &1
--
def PASSWORD = &2
--
def XMLDIR = "&3"
--
alter user &USERNAME identified by &PASSWORD account unlock
/
grant UNLIMITED TABLESPACE to &USERNAME
/
grant create any directory, drop any directory to &USERNAME
/
grant SELECT_CATALOG_ROLE to &USERNAME
/
grant SELECT ANY DICTIONARY to &USERNAME
/
grant unlimited tablespace to &USERNAME
/
--
connect &USERNAME/&PASSWORD
--
declare
  cursor getTables
  is
  select TABLE_NAME
    from USER_XML_TABLES
   where TABLE_NAME in ('DATA_STAGING_HOL');
begin
  for t in getTables() loop
    execute immediate 'DROP TABLE "' || t.TABLE_NAME || '" PURGE';
  end loop;
end;
/
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
  cursor getSchemas
  is
  select SCHEMA_URL
    from USER_XML_SCHEMAS
   where SCHEMA_URL in ( 'http://localhost:8080/source/schemas/poSource/xsd/purchaseOrder.xsd');
begin
  for s in getSchemas() loop
    DBMS_XMLSCHEMA.deleteSchema(s.SCHEMA_URL,DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE);
  end loop;
end;
/  
purge recyclebin
/
create table DATA_STAGING_HOL
    of XMLTYPE
/
create or replace directory XMLDIR as '&XMLDIR'
/
declare 
  cursor getFolderContents
  is
  select ANY_PATH
    from RESOURCE_VIEW
   where UNDER_PATH(res,1,'/home/&USERNAME') = 1;
begin
  for r in getFolderContents loop
    dbms_xdb.deleteResource(r.ANY_PATH,DBMS_XDB.DELETE_RECURSIVE_FORCE);
  end loop;
  commit;
end;
/
declare
  V_RESULT boolean;
  V_XSD_PATH varchar2(1024) := '/home/&USERNAME/PurchaseOrder.xsd';
begin
  if DBMS_XDB.existsResource(V_XSD_PATH) then
    DBMS_XDB.deleteResource(V_XSD_PATH);
  end if;
  V_RESULT := DBMS_XDB.createResource(V_XSD_PATH,bfilename('XMLDIR','PurchaseOrder.xsd'));
  commit;
end;
/
select ANY_PATH
  from RESOURCE_VIEW
 where UNDER_PATH(res,'/home/&USERNAME') = 1
/
ne on
--
commit
/
quit
