. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        $usrflag = checkUser($name)
        if($usrflag) {
            Write-Host "This user already exists!"
            exit
            }
        else {
            $passflag = checkPassword $password

            if($passflag) {
                createAUser $name $password

                Write-Host "User: $name is created." | Out-String

                }
            else {
                Write-Host "Password doesn't meet requirements"
                continue
                }
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $exists = checkUser $name

        if($exists){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else {
            Write-Host "User does not exist"
            continue
        }
    }


    # Enable a user
    elseif($choice -eq 5){

        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $exists = checkUser $name

        if($exists) {
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        else {
            Write-Host "User Does Not exist"
            continue
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        $exists = checkUser $name

        if($exists) {

            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }

        else {
            write-Host "User Does Not Exist"
            continue
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"
        $time = Read-Host -Prompt "Please enter how many days you would like logs from"

        $exists = checkUser $name
        if($exists) {
            $userLogins = getLogInAndOffs $time
            
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else {
            Write-Host "Username does not exist"
            continue
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        $time = Read-Host -Prompt "Please enter how many days you would like logs from"

        $exists = checkUser $name

        if($exists) {

            $userLogins = getFailedLogins $time

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else {
            Write-Host "Username does not exist"
            continue
        }
            
    }

    elseif($choice -eq 9){
        $days = Read-Host -Prompt "How many days would you like logs for?"
        $usrLogins = getFailedLogins $days
        $loginsByUsr = $usrLogins | Group-Object "User"`
                                  | Select-Object Name, Count`
                                  | Where-Object {$_.Count -ge 10}
        Write-Host ($loginsByUsr | Format-Table | Out-String)

            
    }

    else {
        Write-Host "Please choose a valid option"
        continue
    }
}
