#!/bin/bash

<< 'MULTILINE-COMMENT'
	2022.11 Maintainer: Badełek Piotr
	Script for capture TCP/IP packets using packets sniffer tool - tcpdump
	Analyze packets received or transferred by SSH over a specific interface
	Can execute with follow pattern: ./recon.sh <IP>
	If SSH port on specified interface is open, script execute tcpdump tool
	pcap format file (which using tcpdump) can be read by Wireshark (Network Protocol Analyzer) 
MULTILINE-COMMENT
	
REQUIRED_PKG="tcpdump"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")

echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "Cannot find required package: $REQUIRED_PKG. Please install it manually before execute script."
  exit 1
fi

echo "Execute script with following pattern: ./recon.sh <IP>"
echo "If not, private IP of your interface will be get"

get_ip=$(hostname -I | awk '{print $1}')
interface=$(ip route get 8.8.8.8 | sed -nr 's/.*dev ([^\ ]+).*/\1/p')

# If not given IP address, get private one through hostname
if [ -z "$1"  ]
then
	ip=$get_ip
else
	ip=$1
fi

printf "\n----- NMAP -----\n\n" > results
echo "Running Nmap..."
nmap $ip >> results

# If ssh port is open Scan packets with tcpdump
while read line
do
	if [[ $line==*open* ]] && [[ $line==*ssh* ]]
	then
		# TODO: capture ssh trafic
		sudo tcpdump -i $interface >> results
		exit 1
	else
		echo "SSH port for interface: $interface is not open"
		exit 1
	fi
done < results
