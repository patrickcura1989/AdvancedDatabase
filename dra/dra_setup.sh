echo "******************************************* "
echo "For demo purposes ONLY"
echo "Run as the OS user who installed the Oracle software, e.g. oracle"

./dra_archivelog.sh

rman target / @dra_full_backup.rmn 

echo "Basic setup done."
echo "Now, run one of the setup scripts for a specific scenario."
exit