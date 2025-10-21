# Display Only IP addresses for 404 (Not Found records)

# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Get $notfounds record that match to the regex
$ipsUnorganized = $regex.matches($notfounds)

# Get ips as ps customobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value;}
}

$ips | Where-Object { $_.IP -ilike "10.*" }