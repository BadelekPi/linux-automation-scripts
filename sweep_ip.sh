#!/usr/bin/bash

for ip in {1..254}
do
	ping -c 1 192.168.0.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done
