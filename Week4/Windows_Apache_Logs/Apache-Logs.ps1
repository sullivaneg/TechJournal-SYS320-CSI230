# Write a function called Apache-Logs.ps1 that will take 3 inputs:
# A) The page visited or referred from (index.html, page1.html,...)
# B) HTTP Code Returned
# C) Name of the Web Browser
# Gives one output: IP addresses that have visited or referred from, 
# with the given web browser, and got the given HTTP response.

<#********************************************************************************************
Function: Gets the Ip addresses that have visted or referred from a web page with specific inputs
Inputs: 1) The page visited or referred from (index.html, page1.html,...)
        2) HTTP Code Returned
        3) Name of the Web Browser
Output: IP addresses that have visited or referred from, with the given web browser, 
        and got the given HTTP response.
***********************************************************************************************#>

function getVisitorIps($page, $http, $browser){

    # Define a Regex for IP addresses
    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    # Get only logs that contain the status code, page, and browser name
    $logs = Get-Content C:\xampp\apache\logs\access.log | `
        Select-String $page | Select-String $http | Select-String $browser

   #Get $ips record that match the regex
   $ipsUnorganized = $regex.Matches($logs)

   #Initiate Array
   $ips = @()
   foreach ($ip in $ipsUnorganized) {
       #Create the Custom Object
       $ips += [pscustomobject]@{ "IP" = $ip.value }
   }
   Return $ips
}