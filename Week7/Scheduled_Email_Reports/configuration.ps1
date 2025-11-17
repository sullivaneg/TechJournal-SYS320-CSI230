function readConfiguration($file_path) {
    $config_table = @()
    $file_content = Get-Content -Path $file_path

    $days = $file_content[0]
    $time = $file_content[1]

    $config_table +=[pscustomobject]@{"Days Evaluating" = $days;`
                                      "Time Scheduled" = $time;`
                                          }
    $config_table | Format-Table -Autosize
}

function changeConfiguration($file_path) {
Write-Host "`n"
        Write-Host "Changing your configuration...`n"

        #Input Integer validation (Source: @veefu on stackoverflow)
        $days = 0
        $inputValid = $false

        do {
            $try_days = Read-Host -Prompt "How many days of logs would you like?"
            if ([int]::TryParse($try_days, [ref]$days)) {
                $inputValid = $true
            } else {
                Write-Host "`nInvalid Input: Please enter an integer`n" -ForegroundColor Red
            } 
        } while (-not $inputValid)

        #Time Input Validation
        $inputValid = $false

        do {
            $time = Read-Host -Prompt "What execution time would you like (H:MM AM/PM)"

            if ($time -match "^([0-1]?[0-9]|2[0-3]):[0-5][0-9]\s[AP]M") {
                $inputValid = $true
            } else {
                Write-Host "`nInvalid Input: Please enter a time in the format (H:MM AM/PM)`n" -ForegroundColor Red
            } 
        } while (-not $inputValid)

        Set-Content -Path $file_path -Value $days, $time
        Write-Host "`nFile Changed"
}

function configurationMenu($file_path){

    $Prompt = "`n"
    $Prompt += "Please choose your operation:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $True

    while($operation){

    
        Write-Host $Prompt | Out-String
        $choice = Read-Host 


        if($choice -eq 3){
            Write-Host "`nGoodbye" | Out-String
            exit
            $operation = $false 
        }

        elseif($choice -eq 1){
            readConfiguration $file_path

        }

        elseif($choice -eq 2){
            changeConfiguration $file_path
        }

        else {
            Write-Host "Please choose a valid option"
            continue
            }
    }
}

# Main
#$file_path = "~\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\configuration.txt"
#configurationMenu $file_path