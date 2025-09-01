# Get Ipv4 address from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 |Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ipaddress

# Get IPv4 PrefixLength from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).PrefixLength

# Show me what classes there are of Win32 Library that starts with Net
Get-WmiObject -List | Where-Object {$_.Name -ilike "Win32_Net*"}

#Sort them alphabetically
Get-WmiObject -List | Where-Object {$_.Name -ilike "Win32_Net*"} | Sort-Object

# Get DHCP Server IP
Get-CimInstance win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer

# Hide Table headers
Get-CimInstance win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders

# Get DNS Server IPs for Ethernet Interface and only display the first one
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]


