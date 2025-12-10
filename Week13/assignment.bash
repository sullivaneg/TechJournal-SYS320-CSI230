#! /bin/bash

# Using xmlstarlet to extract table
link="10.0.17.47/Assignment.html"

fullPage=$(curl -sL "$link")
#toolOutput=$(echo "$fullPage" | \
#xmlstarlet format --html --recover 2>/dev/null | \
#xmlstarlet select --template --copy-of \
#"//html//body//table//tr")

#echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                    # sed -e 's/&amp;//g' | \
                     #sed -e 's/<tr>//g' | \
                     #sed -e 's/<td[^>]*>//g' | \
                     #sed -e 's/<\/td>/;/g' | \
                     #sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     #sed -e 's/<[/\]\{0,1\}nobr>//g' \
               # > tables.txt
rows=$(echo "$rows" | \
xmlstarlet fo --html --recover 2>/dev/null | \
xmlstarlet sel -t -m "//table/tr" -c "." -n)

# Temp
temp=$(echo "$rows" |
grep -A6 "Temperature" |
sed 's/<[^>]*>//g' |
grep -v Temperature | grep -v Date |
sed '/^\s*$/d')

# Pressure
pressure=$(echo "$rows" |
grep -A6 "Pressure" |
sed 's/<[^>]*>//g' |
grep -v Pressure | grep -v Date |
sed '/^\s*$/d')

# Covert to Arrays
tempValues=($(echo "$temp"))
pressureValues=($(echo "$press"))

len=${#tempValues[@]}

# Merge and Print Tables
for ((i=0; i<$len; i+2)); do
    t="${tempValues[$i]}"
    date="${tempValues[$i+1]}"
    p="${pressureValues[$i]}"
    echo "$p $t $date"
done
    
