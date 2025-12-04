#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
# I created a test user and generated failed logins using su
    bad_logins=$(cat $authfile | grep "authentication failure" | cut -d' ' -f1,3,17)
    echo $bad_logins
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: emma.sullivan@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp emma.sullivan@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 
echo "To: emma.sullivan@mymail.champlain.edu"> emailform2.txt
echo "Subject: Failed Logins" >> emailform2.txt
getFailedLogins >> emailform2.txt
cat emailform2.txt | ssmtp emma.sullivan@mymail.champlain.edu

