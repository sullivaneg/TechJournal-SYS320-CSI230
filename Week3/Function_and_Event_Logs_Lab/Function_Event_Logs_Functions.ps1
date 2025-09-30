<#**********************************************************************************************************************
    Function: Get User Logins and Logoffs
    Input: 1) Number of Days the user wants the logs for
    Output: Table with Time, Id, Event, and User for the logins and logoffs
    ******************************************************************************************************************#>

function getLoginsouts($days){

    # Get login and logoff records and save to a variable
    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

    # Empty Array 
    $loginoutsTable = @()
    for($i=0; $i -lt $loginouts.Count; $i++){

    #Creating Event Property Value
    $event = ""
    if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

    #Creating User Property Value
    $user_SID = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
    $user = $user_SID.Translate([System.Security.Principal.NTAccount])

    #Adding each new line (in the form of a custom object) to our empty array
    $loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                           "Id" = $loginouts[$i].InstanceId;
                                        "Event" = $event;
                                         "User" = $user.Value;
                                         }
    }

    echo "Showing Logins/Logouts for last $days days..."
    $loginoutsTable
}

<#***********************************************************************************************************************
    Function: Get computer start and shutdown times
    Input: 1) Days that we should go back in logs
           2) "up" or "down" to get just start ups, shutdowns or nothing for both
    Output: Table with Time, Id, Event, and User for the shut downs and start ups
***********************************************************************************************************************#>

function getStartups_Shutdowns($days, $upordown) {

    if($upordown -ne $null){$upordown = $upordown.ToLower()}

    # Get login and logoff records and save to a variable
    $offups = (Get-EventLog System -Source EventLog -After (Get-Date).AddDays(-$days) | Where-Object {$_.EventID -in 6005, 6006, 6008})

    # Empty Array 
    $offupsTable = @()
    for($i=0; $i -lt $offups.Count; $i++){

    #Creating Event Property Value
    $event = ""
    if($offups[$i].EventId -eq 6005) {$event="Startup"}
    if($offups[$i].EventId -eq 6006) {$event="Clean Shutdown"}
    if($offups[$i].EventId -eq 6008) {$event="Unexpected Shutdown"}
    
    if($upordown -eq "up") {
        if($event -in "Clean Shutdown", "Unexpected Shutdown") {continue}
        }
    if($upordown -eq "down") {
        if($event -eq "Startup"){continue}
        }

    #Adding each new line (in the form of a custom object) to our empty array
    $offupsTable += [PSCustomObject]@{"Time" = $offups[$i].TimeGenerated;
                                           "Id" = $offups[$i].EventId;
                                        "Event" = $event;
                                         "User" = "System";
                                         }
    }

    echo "Showing EventLog for last $days days..."
    $offupsTable
}


