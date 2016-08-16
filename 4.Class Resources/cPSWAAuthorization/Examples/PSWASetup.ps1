# Setup before demo

#Add DNS Zone and Record for DC
Add-DnsServerPrimaryZone -ComputerName DC -name Company.com -ReplicationScope Forest
Add-DnsServerResourceRecordA -ComputerName dc -name PSWA -ZoneName Company.com -IPv4Address 192.168.3.51

copy-item -path c:\pwa\* -Destination "\\DC\c$\Program Files\WindowsPowerShell\Modules" -recurse -force

#Copy modules and install certificate
$servers='s1'

$servers | ForEach-Object {copy-item -path c:\pwa\* -Destination "\\$_\c$\Program Files\WindowsPowerShell\Modules" -recurse -force}
Invoke-Command -ComputerName $servers {certutil -p P@ssw0rd -importpfx "C:\Program Files\WindowsPowerShell\Modules\PSWA.pfx"}

# set LCM
ISE C:\pwa\2.LCMSetup.ps1

#Examine Config
ISE C:\PWA\1.PWAConfig.ps1

#Show Custom Resource
ISE C:\pwa\cPSWAAuthorization\cPSWAAuthorization.psm1

#Run config then test
Start iexplore https://PSWA.company.com

