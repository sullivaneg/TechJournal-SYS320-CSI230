#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Invalid parameters -- Format should look like bash finalC2.bash <log file> <IOC file>"
    exit
fi

logfile="$1"
iocfile="$2"

# Create report file
> "report.txt"

while read -r ioc; do
    grep $ioc $logfile | cut -d ' ' -f1,4,7 | tr -d '[]"'  >> "report.txt"
done < $iocfile
    
