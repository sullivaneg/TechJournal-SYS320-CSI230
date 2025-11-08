. (Join.Path $PSScriptRoot Function_Event_Logs(Functions).ps1)

clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = getLoginsouts 15
$loginoutsTable
echo ""

# Get Shutdowns from the last 25 days
$shutdownsTable = getStartups_Shutdowns 25 down
$shutdownsTable
echo ""

# Get Start Ups from the last 25 days
$startupsTable = getStartups_Shutdowns 25 up
$startupsTable
echo ""