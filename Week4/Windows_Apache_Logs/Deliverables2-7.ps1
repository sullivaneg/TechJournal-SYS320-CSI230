# List all Apache Logs
Get-Content C:\xampp\apache\logs\access.log

# List only last 5 logs
Get-Content C:\xampp\apache\logs\access.log -tail 5

#Display only logs that contain 404 (Not Found) or 400 (Bad Request)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

# Display only logs that doesn NOT contain 200 (OK)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

# For every file with .log extension in the directory, only get logs that contain the word "error"
$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# Display last 5 elements of the result array
$A[-5..-1]

