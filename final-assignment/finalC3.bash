#!/bin/bash

file="report.txt"
output="report.html"
dest="/var/www/html"

{
echo "<html>"
echo "<body>"
echo "<head>IOC Report</head>"
echo "<h2>Access logs with IOC indicators:</h2>"
echo "<table>"
echo "<tr>"
echo "<th>IP Address</th>"
echo "<th>Time</th>"
echo "<th>Page Accessed</th>"
echo "</tr>"

while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    date=$(echo "$line" | awk '{print $2}')
    page=$(echo "$line" | awk '{print $3}')

    echo "<tr><td>$ip</td><td>$date</td><td>$page</td></tr>"

done < "$file"

echo "</table>"
echo "</body>"
echo "</html>"
} > "$output"

sudo mv "$output" "$dest/"

echo "Report created"
