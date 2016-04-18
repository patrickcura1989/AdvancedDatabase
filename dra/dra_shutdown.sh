echo "******************************************* "
echo "For demo purposes ONLY:"
echo "* Shutdown database"

sqlplus "/ as sysdba" << EOF
shutdown immediate
EOF