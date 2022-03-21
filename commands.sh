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

# Double paranthesis to assign to variable
var=$((num1+10))
echo "$var"

# Multiplication has precedence
var=$((3*2+1))
echo $var

# Combine two strings in one line with variables
var1="hello"
var2="world"
combine="$var1 $var2"
echo $combine

var3="beauty"
echo combine2="${var1} ${var3} ${var2}"

#Combine with plus operator
var1+=" $var2"
echo $var1

# Create multi-line string var with HEREDOC
string=$(cat<<'END_HEREDOC'
I can
type 
in multilines
END_HEREDOC
)
echo "$string"

# Cat multi-line heredoc text
cat<<LINUXHINT
The current working directory is: $PWD
You are logged in as: $(whoami)
LINUXHINT






