#!/bin/bash

# Display Another users
# _l="/etc/login.defs"
# _p="/etc/passwd"
# l=$(grep "^UID_MIN" $_l)
# l1=$(grep "^UID_MAX" $_l)
# awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max  && $7 != "/sbin/nologin" ) print $0 }' "$_p"

myfile=$(mktemp --suffix ".txt")

# Functions
function cpu_model { echo $(grep 'model name' /proc/cpuinfo | uniq) | cut -d" " -f4-; }
function mem_free { echo "$(awk '/MemFree/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function mem_total { echo "$(awk '/MemTotal/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function disk_space () { 
                        echo -e "Total Disk space" >> $myfile
                        echo -e "$(df -h -t ext4 | awk '{ print $2 }' | awk 'FNR==2')" >> $myfile
                        echo -e "Used disk space" >> $myfile
                        echo -e "$(df -h -t ext4 | awk '{ print $3 }' | awk 'FNR==2')" >> $myfile
                        echo -e "Avail disk space" >> $myfile
                        echo -e "$(df -h -t ext4 | awk '{ print $4 }' | awk 'FNR==2')" >> $myfile
                        echo -e "Used disk space %" >> $myfile
                        echo -e "$(df -h -t ext4 | awk '{ print $5 }' | awk 'FNR==2')" >> $myfile; }
function linux_ver () {
                        echo -e "Operating system" >> $myfile
                        echo -e "$(hostnamectl | awk 'FNR == 6 { print $3" "$4}')" >> $myfile
                        echo -e "Kernel version" >> $myfile
                        echo -e "$(hostnamectl | awk 'FNR == 7 { print $2" "$3}')" >> $myfile; }

if $(sudo -l &> /dev/null); then
    
    # Sudo permission display
    # echo -en "$(sudo -l -U "$(whoami)")" | awk 'FNR == 4 || FNR == 5 {print}'

    # Manufacturer and product name
    # sudo dmidecode | grep -A3 'System Information'

    # Check GPU
    echo -e "=============== PC Stat ===============" >> $myfile
    echo -e "" >> $myfile
    echo -e "GPU_controller"  >> $myfile
    echo -e "GPU_controller,$(sudo lshw -C display)" | awk 'FNR == 2' | cut -d" " -f9- >> $myfile
    echo -e "GPU_product"  >> $myfile
    echo -e "GPU_product,$(sudo lshw -C display)" | awk 'FNR == 3' | cut -d" " -f9- >> $myfile

    # Check CPU
    echo -e "CPU" >> $myfile
    echo -e $("cpu_model") >> $myfile
     
    # Check all RAM mem
    echo -e "Total RAM Mem" >> $myfile
    echo -e $("mem_total") >> $myfile

    # Check available RAM mem
    echo -e "Available RAM Mem" >> $myfile
    echo -e $("mem_free") >> $myfile

    # Check disk space
    disk_space 
    
    # Kernel version
    linux_ver

else

    echo "You dont have sudo"
fi

readarray -t keys < <(sed -n 1~2p $myfile)
readarray -t values < <(sed -n 2~2p $myfile)

for i in "${!keys[@]}" ; do
    echo -e "${keys[$i]}\t=\t${values[$i]}"
done | column -s$'\t' -t

> $myfile

echo -e "=============== Net Stat ==============" >> $myfile
    echo -e "" >> $myfile
echo -e "IP Address" >> $myfile
ip_address=$(ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3,4 | uniq)
echo -e $ip_address >> $myfile
echo -e "Ping time" >> $myfile
echo -e "$(sudo ping -c 1 $ip_address | grep "64 bytes" | cut -d "" -f 4 | tr -d ":" | cut -d " " -f 7 | cut -d "=" -f 2) ms" >> $myfile

# echo -e ""
readarray -t keys < <(sed -n 1~2p $myfile)
readarray -t values < <(sed -n 2~2p $myfile)

for i in "${!keys[@]}" ; do
    echo -e "${keys[$i]}\t=\t${values[$i]}"
done | column -s$'\t' -t