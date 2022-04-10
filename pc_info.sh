#!/bin/bash

# Display Another users
# _l="/etc/login.defs"
# _p="/etc/passwd"
# l=$(grep "^UID_MIN" $_l)
# l1=$(grep "^UID_MAX" $_l)
# awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max  && $7 != "/sbin/nologin" ) print $0 }' "$_p"

# Functions

function cpu_model { echo $(grep 'model name' /proc/cpuinfo | uniq) | cut -d" " -f4-; }
function mem_free { echo "$(awk '/MemFree/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function mem_total { echo "$(awk '/MemTotal/ { printf "%.1f \n", $2/1024/1024 }' /proc/meminfo)"; }
function disk_space { echo "$(df -h -t ext4)"; }

if $(sudo -l &> /dev/null); then
    
    touch pcinfo.txt

    # Sudo permission display
    # echo -en "$(sudo -l -U "$(whoami)")" | awk 'FNR == 4 || FNR == 5 {print}'

    # Manufacturer and product name
    # sudo dmidecode | grep -A3 'System Information'

    # Linux and kernel version
    # echo -en "$(hostnamectl)" | awk 'FNR == 6 || FNR == 7 {print}'

    # Check GPU
    echo -e "GPU controller"  > pcinfo.txt
    echo -e "$(sudo lshw -C display)" | awk 'FNR == 2 || FNR == 3 {print}' | cut -d" " -f4- >> pcinfo.txt
    # echo $("lspci | grep ' VGA ' | cut -d" " -f 1 | xargs -i lspci -v -s {}") | awk 'FNR == 0' || 'FNR == 1 {print}

    # Check CPU
    echo -e "CPU" >> pcinfo.txt
    echo -e $("cpu_model") >> pcinfo.txt
     
    # Check all RAM mem
    echo -e "Total RAM Mem" >> pcinfo.txt
    echo -e $("mem_total") >> pcinfo.txt

    # Check available RAM mem
    echo -e "Available RAM Mem" >> pcinfo.txt
    echo -e $("mem_free") >> pcinfo.txt

    # Check disk space
    echo -e "Disk space" >> pcinfo.txt
    echo -e $("disk_space") >> pcinfo.txt
    
else

    echo "You dont have sudo"
fi

