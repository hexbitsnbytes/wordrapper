#!/usr/bin/env bash
# This script uses and intermediate file to store the result of fold
# Couldnt get it to work as when stored in a variable with bash
# Only with zsh would it work
tempfile=".processed.temp.txt"

fold -s -w 42 $1 > $tempfile

counter=0
while IFS= read line; do
    if [ $counter -eq 0 ]; then
        echo $line > result.txt
    elif [ $(( $counter % 2 )) -eq 0 ]; then
        echo $line | sed 's/\(.\)$/\1\n/' >>  result.txt
    else 
        echo $line >> result.txt
    fi
    counter=$(($counter + 1))
done < $tempfile


green='\033[0;32m'
green='\033[1;33m'
nc='\033[0m'
echo -e "${nc} Usage: ./wordrapper.bash <name-of-file-to-process>"
echo -e "${green} Make sure you have an empty line at the end of your sample file"
rm $tempfile