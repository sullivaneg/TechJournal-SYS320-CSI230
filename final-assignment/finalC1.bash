#!/bin/bash

URL="10.0.17.47/IOC.html"

curl -s "$URL" | xmlstarlet sel -t -m "//table//tr/td[1]" -v "." -n > IOC.txt


