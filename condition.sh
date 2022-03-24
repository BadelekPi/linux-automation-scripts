#!/bin/bash

var=8
# if variable is greater than 5
if [ $var -gt 5  ]
then
	echo "fine"
fi

# logical AND in conditional statement 
if [[ $var -gt 2  ]] && [[ $var -lt 9  ]];
then
	echo "$var is between 2 and 9"
fi

# logical OR in conditional statement
if [[ $VAR -gt 5  ]] || [[ $VAR -lt 1 ]];
then
	echo "$var is greater than 5, but not less than 1"
fi

# if elif else conditional statement
marks=40
if [ $marks -gt 30 ]
then
	echo "Excellent"
elif [ $marks -gt 20 ]
then
	echo "Pretty good"
else
	echo "Not good"
fi

# nesting if condition
num=6
if [ "$num" -gt 1 ]
then
	if [ "$num" -lt 10 ]
	then
		echo "The number lies between 1 to 10"
	fi
fi

# equal operator
if [[ $num = 6 ]]
then
	if [[ $num == 6 ]]
	then
		echo "Double equal if"
	fi
else
	echo "Nvm"
fi

# not equal operator
if [[ $num != 2  ]]
then
	echo "Not equal 2"
fi

# check if string is null
string=''
if [[ $string='' ]]
then
	echo "String is null"
else
	echo "String is not null"
fi

# Classical operators 
num1=5
if (( $num1 >=1 )) && (( $num1 <=10 ))
then
	echo "$num1 Between 1 to 10"
fi

