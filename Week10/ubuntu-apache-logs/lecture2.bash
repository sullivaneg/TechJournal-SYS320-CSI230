#!/bin/bash

countingCurlAccess(){
    file="/var/log/apache2/access.log"

    cat "$file" | grep "curl" | cut -d' ' -f1,12 | sort | uniq -c | sort -nr

}

countingCurlAccess
