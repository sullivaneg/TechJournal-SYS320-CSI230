#Write a PowerShell Script that 
# a) if an instance of it is not running already, it starts Google Chrome Web Browser and Directs it Champlain.edu
# b) if an instance is already running, stops it

function getChrome(){
    # Creat a variable for Chrome and Champlain URL
    $chrome_tab = (Get-Process |Where-Object {$_.Name -eq "chrome"})
    $champlain = "https://www.champlain.edu"

    # Check if it exists
    if ($chrome_tab -eq $null){
        echo "There is no current chrome processes running, starting a new one..."
        Start-Process -FilePath "chrome.exe" -ArgumentList $champlain
        }
    else {
        echo "Found a chrome process running, stopping process..."
        Stop-Process -Name "chrome"
        }

# Verify
Get-Process -Name "chrome"