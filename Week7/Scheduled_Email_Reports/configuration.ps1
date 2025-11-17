function readConfiguration {
    $config_table = @()
    $file_content = Get-Content -Path $file_path

    $config_table +=[pscustomobject]@{"Days Evaluating" = $file_content[0];`
                                      "Time Scheduled" = $file_content[1];`
                                          }
    Write-Host "`nCurrent Configuration"
    $config_table | Format-Table -Autosize
}

function changeConfiguration {
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
        $time = 0
        $temp = 0
        $inputValid = $false

        do {
            $try_time = Read-Host -Prompt "What execution time would you like (H:MM AM/PM)"
            $time = $try_time

            if ([DateTime]::TryParseExact($try_time, "h:mm tt", $null, [System.Globalization.DateTimeStyles]::None, [ref]$temp)) {
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
            readConfiguration

        }

        elseif($choice -eq 2){
            changeConfiguration
        }

        else {
            Write-Host "Please choose a valid option"
            continue
            }
    }
}

# Main
$file_path = "~\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\configuration.txt"
configurationMenu $file_path