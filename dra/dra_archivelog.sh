echo "******************************************* "
echo "For demo purposes ONLY:"
echo "  * Unlock HR account with the Ora-4-you password"
echo "  * Enable ARCHIVELOG mode for database"
echo ""
echo "The script may appear to hang at the SQL prompt"
echo "when the database is shutting down and being"
echo "opened. Wait a few minutes and it should progress."
echo "******************************************* "

sqlplus "/ as sysdba" << EOF

ALTER USER HR IDENTIFIED BY "Ora-4-you" ACCOUNT UNLOCK;
ALTER SYSTEM SET db_recovery_file_dest_size = 10737418240 SCOPE=BOTH;

shutdown immediate
startup mount
alter database archivelog;
alter database open;
archive log list
exit
EOF
