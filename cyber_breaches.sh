#!/bin/bash
REGEX_Country="^[A-Z]{2}$"
REGEX_Year="^[0-9]{4}$"
if [[ -z $1 ]] || [[ -z $2 ]]
then
	1>&2 echo "Error: You are missing arguments!"
	exit 2
elif [[ ! -f $1 ]]
then
	1>&2 echo "Error:count not find file $1"
	exit 1
elif [[ $2 == "maxstate" ]]
then	
	echo tail $1 -n+2 | cut -d $'\t' -f 2 $1 | sort  | uniq -c | sort -rn | head -n 1 | awk '{print "State with greatest number of incidents is:",$2," with count", $1}'	 
elif [[ $2 == "maxyear" ]]
then 
	echo tail $1 -n+2 | cut -d $'\t' -f 8 $1 | sort  | uniq -c | sort -rn | head -n 1 | awk '{print "Year with greatest number of incidents is:",$2,"with count",$1}'
elif [[ $2 =~ $REGEX_Country ]];
then
	awk -F $'\t' '$2 == "'"$2"'" {print $8" "$2}' "$1"  | sort | uniq -c | sort -rn | head -n 1 | awk '{print "Year with greatest number of incidents for","'"$2"'","is in",$2,"with count",$1}' 
elif [[ $2 =~ $REGEX_Year ]];
then 
	awk -F $'\t' '$8 == "'"$2"'" {print $8" "$2}' "$1"  | sort | uniq -c | sort -rn | head -n 1 | awk '{print "State with greatest number of incidents for","'"$2"'","is in",$3,"with count",$1}'
else
	echo "The max commands are either maxstate or maxyear"
fi
