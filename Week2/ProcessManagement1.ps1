# Write a PowerShell script that lists every procss for which ProcessName starts with 'C'.
Get-Process -Name C*

# Write a Powershell script that lists every process for which the path does not include the string 'system32'
(Get-Process | Where-Object {$_.Path -inotlike "*system32*"} | Select-Object Id, ProcessName, Path)

# Write a Powershell script that lists every stopped service, orders it alphabetically and saves it to a csv file
(Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object | Export-Csv -Path .\StoppedServices.csv)
