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


