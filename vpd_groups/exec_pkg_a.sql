col storage_a format a12
col date_a format a9
col storage_b format a12
col date_b format a9
col end_user format a10
col policy_group format a20
set echo on
exec dbms_session.set_identifier('provider_a');
exec sec_admin.provider_package.set_provider_context;
select * from rfid_data;