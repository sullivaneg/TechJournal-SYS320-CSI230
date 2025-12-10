#! /bin/bash

# Using xmlstarlet to extract table
link="10.0.17.47/Assignment.html"

fullPage = $(curl -sL "$link")
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' \
                > tables.txt
