echo "******************************************* "
echo "For demo purposes ONLY:"
echo "* Corrupt datafiles to produce failures"

cp C:/app/student/oradata/patrickcura/users01.dbf users01.dbf.old

rm -Rf C:/app/student/oradata/patrickcura/users01.dbf

mv C:/app/student/oradata/patrickcura/example01.dbf C:/app/student/oradata/patrickcura/example01.dbf.old 

exit
