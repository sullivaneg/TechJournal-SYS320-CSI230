$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

$operation = $True
$file_path = "~\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\configuration.txt"

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 3){
        Write-Host "`nGoodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $config_table = @()
        $file_content = Get-Content -Path $file_path

        $config_table +=[pscustomobject]@{"Days Evaluating" = $file_content[0];`
                                          "Time Scheduled" = $file_content[1];`
                                          }
        Write-Host "`nCurrent Configuration"
        $config_table | Format-Table -Autosize

    }

    elseif($choice -eq 2){
        Write-Host "`n"
        Write-Host "Changing your configuration...`n"
        $days = Read-Host -Prompt "How many days of logs would you like?"
        $time = Read-Host -Prompt "What execution time would you like (HH:MM AM/PM)"

        Set-Content -Path $file_path -Value $days, $time
        Write-Host "`nFile Changed"
    }

    else {
        Write-Host "Please choose a valid option"
        continue
        }
}