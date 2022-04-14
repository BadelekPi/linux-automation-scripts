#!/bin/bash

# Display Another users
# _l="/etc/login.defs"
# _p="/etc/passwd"
# l=$(grep "^UID_MIN" $_l)
# l1=$(grep "^UID_MAX" $_l)
# awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max  && $7 != "/sbin/nologin" ) print $0 }' "$_p"

filename="pcinfo"
touch $filename.txt
> $filename.txt


# Functions
function cpu_model { echo $(grep 'model name' /proc/cpuinfo | uniq) | cut -d" " -f4-; }
function mem_free { echo "$(awk '/MemFree/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function mem_total { echo "$(awk '/MemTotal/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function disk_space () { 
                        echo -e "Total Disk space" >> ""$1".txt"
                        echo -e "$(df -h -t ext4 | awk '{ print $2 }' | awk 'FNR==2')" >> ""$1".txt"
                        echo -e "Used disk space" >> ""$1".txt"
                        echo -e "$(df -h -t ext4 | awk '{ print $3 }' | awk 'FNR==2')" >> ""$1".txt"
                        echo -e "Avail disk space" >> ""$1".txt"
                        echo -e "$(df -h -t ext4 | awk '{ print $4 }' | awk 'FNR==2')" >> ""$1".txt"
                        echo -e "Used disk space %" >> ""$1".txt"
                        echo -e "$(df -h -t ext4 | awk '{ print $5 }' | awk 'FNR==2')" >> ""$1".txt"; }
function linux_ver () {
                        echo -e "Operating system" >> ""$1".txt"
                        echo -e "$(hostnamectl | awk 'FNR == 6 { print $3" "$4}')" >> ""$1".txt"
                        echo -e "Kernel version" >> ""$1".txt"
                        echo -e "$(hostnamectl | awk 'FNR == 7 { print $2" "$3}')" >> ""$1".txt"; }

if $(sudo -l &> /dev/null); then
    
    # Sudo permission display
    # echo -en "$(sudo -l -U "$(whoami)")" | awk 'FNR == 4 || FNR == 5 {print}'

    # Manufacturer and product name
    # sudo dmidecode | grep -A3 'System Information'

    # Check GPU
    echo -e "GPU_controller"  > $filename.txt
    echo -e "GPU_controller,$(sudo lshw -C display)" | awk 'FNR == 2' | cut -d" " -f9- >> $filename.txt
    echo -e "GPU_product"  >> $filename.txt
    echo -e "GPU_product,$(sudo lshw -C display)" | awk 'FNR == 3' | cut -d" " -f9- >> $filename.txt

    # Check CPU
    echo -e "CPU" >> $filename.txt
    echo -e $("cpu_model") >> $filename.txt
     
    # Check all RAM mem
    echo -e "Total RAM Mem" >> $filename.txt
    echo -e $("mem_total") >> $filename.txt

    # Check available RAM mem
    echo -e "Available RAM Mem" >> $filename.txt
    echo -e $("mem_free") >> $filename.txt

    # Check disk space
    disk_space "$filename"
    
    # Kernel version
    linux_ver "$filename"

else

    echo "You dont have sudo"
fi


readarray -t keys < <(sed -n 1~2p pcinfo.txt)
readarray -t values < <(sed -n 2~2p pcinfo.txt)

for i in "${!keys[@]}" ; do
    echo -e "${keys[$i]}\t=\t${values[$i]}"
done | column -s$'\t' -t


