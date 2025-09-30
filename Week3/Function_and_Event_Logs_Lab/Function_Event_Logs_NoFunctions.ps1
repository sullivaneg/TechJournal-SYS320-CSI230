# Get login and logoff records and save to a variable
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

# Empty Array 
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

#Creating Event Property Value
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

#Creating User Property Value
$user = $loginouts[$i].ReplacementStrings[1]

#Adding each new line (in the form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                       "Id" = $loginouts[$i].InstanceId;
                                    "Event" = $event;
                                     "User" = $user;
                                     }
}

$loginoutsTable