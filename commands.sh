#!/bin/bash

touch filetouch.txt # simple create text file

ln -s $HOME/text.txt link1
ls
echo "Writing in link1" >> link1

a=2
b=4

# Echo number modulus second number
echo "$(($a % $b))"

# Echo number to exponent of second number
var=$((8**2))
echo $var

# 5 mathematical expression 
num1=25
num2=5

expr $num1+$num2
expr $num1 % $num2
echo expr $num1 \* $num2
echo "$(($num1+$num2))"
liczba="$(($num1+$num2))"


