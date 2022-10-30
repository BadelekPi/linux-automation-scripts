#!/bin/bash 

<< 'MULTILINE-COMMENT'
	2022.10 Maintainer: Badelek Piotr
	Script for creating automatic, daily backups of home directory
	To set a script to run automatically, extend /etc/crontab by:
	00 03 * * 1-6 root full-path-to-current-script
	If any backups is older than week, it will be removed.
MULTILINE-COMMENT

var_date=`date +%Y%m%d.%H%M`
tar czf /opt/backups/Daily-$var_date.tar.gz /home

for filename in /opt/backups/Daily*.tar.gz; do
	backup_date="$(echo $filename | sed -r 's/.*-([0-9]*)\..*/\1/g')"
	if [ $(($(date +%Y%m%d)-backup_date)) -gt 7 ]
	then
		echo "Backup $filename was introduced over a week ago. Its removal was ordered"
		sudo rm $filename
	fi
	echo "Current backups in folder: $filename"
done
