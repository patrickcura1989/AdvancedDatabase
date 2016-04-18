echo "******************************************* "
echo "For demo purposes ONLY:"
echo "Create block corruption for scenario 2"
echo "Please wait setup in process"

# cp C:/app/student/oradata/patrickcura/example01.dbf example01.dbf.old

sqlplus /nolog << EOF
connect / as sysdba
@dra2_setup2.sql
EOF
chmod 777 dra2*
./dra2_setup2a.sh
./dra2_setup2b.sh
./dra2_setup2c.sh

sqlplus /nolog << EOF
connect / as sysdba
@dra2_setup3.sql
EOF
echo "Setup 2 completed."
exit



