#!/bin/bash


echo -e "one\ttwo"

echo "Send text to file" > ./file.txt # comment

echo "Append text to file" >> ./file.txt

<<LINUXHINT_MESSAGE
MultiLine
Comments Example
LINUXHINT_MESSAGE

var="variable"
echo $var # print value of this variable

a="this is a car"
b="this is merc"
c="${a} ${b}" # format printing

var_path=$HOME
echo $var_path


