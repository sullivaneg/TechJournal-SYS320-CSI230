# Create a menu with the options
# 1. Display Last 10 apache logs
# 2. Display last 10 failed logins for all users
# 3. Display at risk users
# 4. Start chrome web browser and navigate it to champlain.edu - if no instances of Chrome are running
# Prompt the menu until user enters 5, verify that user only enters 1-5
# Display proper verification messages

.(Join-Path $PSScriptRoot ../Week4/Parsing_Apache_Logs/Parsing-Apache-Logs.ps1)
.(Join-Path $PSScriptRoot ../Week6/Local-User-Management-Menu/Event-Logs.ps1)
.(Join-Path $PSScriptRoot ../Week2/ProcessManagement_Script4.ps1)

#clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last ten Apache logs`n"
$Prompt += "2 - Display last ten failed logins for all users`n"
$Prompt += "3 - Display At Risk Users`n"
$Prompt += "4 - Open Chrome`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # elseif($choice -eq 1){
         #$logs = ApacheLogs1 $tableRecords | Format-Table -AutoSize -Wrap 
         #$logs | Select-Object -Last 10
    #}

    elseif($choice -eq 2){
       $fails = getFailedLogins 365
       Write-Host ($fails | Select-Object { $_.User -ilike "*"} -First 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 3){ 
        getRiskUsers
    }
        
    elseif($choice -eq 4){
        getChrome
    }

    else {
        Write-Host "Please choose a valid option"
        continue
    }
}