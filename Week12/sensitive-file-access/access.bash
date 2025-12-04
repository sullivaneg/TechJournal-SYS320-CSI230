# This script will log access to  userlogs-1.bash in file fileaccesslog.txt and
# email user the contents of fileaccesslog.txt

# Update Log File
time=$(date '+%A %Y-%m-%d %H-%M-%S %p')
echo "This file was accessed $time" >> fileaccesslog.txt

# Email User
echo "To:emma.sullivan@mymail.champlain.edu" > emailform.txt
echo "Subject: Sensitive File Accessed" >> emailform.txt
cat fileaccesslog.txt >> emailform.txt
cat emailform.txt | ssmtp emma.sullivan@mymail.champlain.edu
