#! /bin/bash

# Using xmlstarlet to extract table
link="10.0.17.47/Assignment.html"

fullPage=$(curl -sL "$link")

# Temp
temp=$(echo "$fullPage" |
xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='temp']/tr" -v "td[1]" -n) 

# Pressure
pressure=$(echo "$fullPage" |
xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='press']/tr" -v "td[1]" -n)

# time
dtime=$(echo "$fullPage" |
xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='temp']/tr" -v "td[2]" -n)

# Loop count
count=$(echo "$temp" | wc -l)
for ((i=1; i<=count; i++));
do
    temp=$(echo "$temp" | head -n $i | tail -n 1)
    press=$(echo "$pressure" | head -n $i | tail -n 1)
    dtime=$(echo "$dtime" | head -n $i | tail -n 1)

    echo -e "$press $temp $dtime"
done
    
