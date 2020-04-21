#!/bin/bash


cntForExit=0
trap 'cntForExit=$(( $cntForExit + 1 ))' SIGINT
echo -e "Greetings! You can ask for\ntime\nweather\nsearch\nOr try to find a proverb that suit for given words\nFor exit push ctrl+c three times"
while [ $cntForExit -lt 3 ]
do
	echo "What do you want?"
	read input
	while read line
	do
		cntForWords=0
		for word in $input; do
			if echo $line | grep -q "$word"; then
				let cntForWords++
				if [ $cntForWords -eq 2 ]; then
					echo $line
				fi
			fi
		done
	done < proverbs.txt
	if [ "$input" == "time" ]; then
		echo "`date`"
	fi
	if [ "$input" == "weather" ]; then
		echo "Please, enter the city:"
		read city
		curl "http://wttr.in/$city"
	fi
	if [ "$input" == "search" ]; then
		echo "Enter your question"
		read question
		buff=${question:10}
		echo "http://google.com/search?q=$question" | tr " " "+"
	fi
done
