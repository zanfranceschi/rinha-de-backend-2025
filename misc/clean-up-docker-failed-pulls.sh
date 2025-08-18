cleanup_file=cleanup

grep -l "Error toomanyrequests" ../participantes/*/docker-compose.logs | sed -e 's/docker-compose.logs/k6.logs/g' > $cleanup_file
grep -l "Error toomanyrequests" ../participantes/*/docker-compose.logs | sed -e 's/docker-compose.logs/partial-results.json/g' >> $cleanup_file
grep -l "Error toomanyrequests" ../participantes/*/docker-compose.logs | sed -e 's/docker-compose.logs/docker-compose.logs/g' >> $cleanup_file

sed -i 's/^/rm /' $cleanup_file

chmod +x $cleanup_file

sh ./$cleanup_file

rm $cleanup_file
