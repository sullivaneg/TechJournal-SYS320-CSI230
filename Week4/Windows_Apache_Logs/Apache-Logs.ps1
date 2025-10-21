# Write a dunction called Apache-Logs.ps1 that will take 3 inputs:
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

function getVistorIps($page, $http, $browser){

# Get only logs that contain the status code, page, and browser name
$bypage = Get-Content C:\xampp\apache\logs\access.log | Select-String " $page "
$bycode = Get-Content $bypage | Select-String " $http "
$bybrowser = Get-Content $bycode | Select-String " $browser "

# Define a Regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Get strings in $bybrowser that match the regex
$ipsUnorganized = $regex.matches($bybrowser)

# ips as a customobject
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value;}
}

$ips | Where-Object { $_.IP -ilike "10.*" }
}

# Testing Section
# Status: 404, Browser: Mozilla, index.html

getVistorIps(" index.html ", " 404 ", "Mozilla")