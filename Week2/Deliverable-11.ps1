# Without changing the directory (do your operations recursively without getting in to the child directory)
# Find ever .csv file recursively and change their extensions to .log
# Recursively display all the files (not directories)

$files = - - 
$files | Where-Object - {$_.Extension - '.csv', '.log'}
Get-
