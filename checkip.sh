#!/bin/bash
##############################################################################
#Script to Return IP Address from checkip.dyndns.org
#Auther: Kenneth Lynch
#Date: 7-13-16
##############################################################################
export DEBIAN_FRONTEND=noninteractive
#place date into variable
d=$(date +%F_%T) 

#get results of querying checkip.dyndns.org
ipstuff=`wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'` 

if [ $? -ne 0 ]
  then echo "No data returned" > ipcheck.txt
fi

#print date and wget results to file
echo $d  '|'  $ipstuff > ipcheck.txt

exit 0
