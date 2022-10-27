#!/bin/bash
# Home Directory Backups

var_date=`date +%Y%m%d.%H%M`
#tar czf /opt/backups/Daily-$var_date.tar.gz /home

for filename in /opt/backups/Daily*.tar.gz; do
	backup_date="$(echo $filename | sed -r 's/.*-([0-9]*)\..*/\1/g')"
	echo "backup_date: $backup_date"
	echo "var_date: $var_date"
	echo $(($(date +%Y%m%d)-backup_date))
	#echo $backup_date
		
	echo "Current backups in folder: $filename"

done
