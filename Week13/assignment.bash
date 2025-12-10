#!/bin/bash

link="10.0.17.47/Assignment.html"
fullPage=$(curl -sL "$link")

# Read into arrays
mapfile -t temp_array < <(echo "$fullPage" | xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='temp']/tr" -v "td[1]" -n)

mapfile -t press_array < <(echo "$fullPage" | xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='press']/tr" -v "td[1]" -n)

mapfile -t time_array < <(echo "$fullPage" | xmlstarlet format | \
xmlstarlet select -t -m "//table[@id='temp']/tr" -v "td[2]" -n)

# Loop
for ((i=0; i<${#temp_array[@]}; i++));
do
    echo -e "${press_array[i]} ${temp_array[i]} ${time_array[i]}"
done

