. (Join-Path $PSScriptRoot Apache-Logs.ps1)

<#******************************************************************************
Function: Counts how many times each Ip shows up in the output array from getVisitorIps
Input: Array
Output: Number of times visited and Ip Address
Note: I'm going to comment out the IPs needing to be 10.* because my Kali IP starts with 140
******************************************************************************#>
function ipCounts($ips){
    $ipsoftens = $ips #| Where-Object { $_.IP -ilike "10.*" }
    $counts = $ipsoftens | group IP
    $counts | Select-Object Count, Name
    Write-Host $counts
    }



# Testing Section

# Status: 304, Browser: Mozilla, page1.html
# Mozilla is my Kali Browser
$ips = getVisitorIps "/page1.html" " 304 " "Mozilla"
ipCounts $ips

#Status: 200, Browser: Chrome, Page: Any
$ips = getVisitorIps "/*" " 200 " "Chrome"
ipCounts $ips