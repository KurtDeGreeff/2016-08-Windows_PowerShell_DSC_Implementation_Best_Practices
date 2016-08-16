# Reset Target computer to PULL for easier testing - works the same for Pull
ise C:\Scripts\DSCCamp\5.SecureCreds\1.Reset_LCM_Push.ps1
Get-DscLocalConfigurationManager -CimSession Target
Remove-DscConfigurationDocument -CimSession Target -Stage Current

# Credentials 
ise C:\Scripts\DSCCamp\5.SecureCreds\2.config_Credentials.ps1 # Will Fail
# In Error message, the following article is listed:
Start iexplore http://go.microsoft.com/fwlink/?LinkId=393729 # This is good

# This is a mistake!
ise C:\Scripts\DSCCamp\5.SecureCreds\3.Config_Credential.ps1
# Show it worked and Bad things in MOF
ise C:\DSCSecure\target.mof


# need proper certificate script
# 1. ON DC - Open MMC and Add Certificate Authority snapin
# 2. In Certificate Template, add New template Workstation Authentication
# 3. On other Computer, Target, Open MMC - Add Certificates for local computer 
# 4. Create and Export certificate in Personal\Certificates store - name ClientAuth.Cer
# 5. Copy .CER to Target/Author computers (This is public key only)
# 6. Install .CER on target


New-Item -Path \\Target\c$\ -name Cert -ItemType Directory
Copy-Item -Path C:\Scripts\DSCCamp\5.SecureCreds\clientAuth.cer -Destination \\target\C$\Cert\ClientAuth.cer -Force 
Explorer \\target\c$\cert

# Install certificate on targets in the "MY" store
Invoke-Command -ComputerName Target {certutil -addstore -f "My" "C:\cert\ClientAuth.cer"}

# Get the Thumbprint for the Config and LCM
Invoke-Command -Computername Target {Get-Childitem Cert:\LocalMachine\My | Where-Object {$_.Issuer -like "*Company*"} | Select-Object -ExpandProperty ThumbPrint}
ise C:\Scripts\DSCCamp\5.SecureCreds\5.New_LCM_Push.ps1

# Make a new Mof with secured creds
ise C:\Scripts\DSCCamp\5.SecureCreds\4.Config_Credential.ps1
ise C:\DSCSecure\Target.mof
# Run the Config!!!
Start-DscConfiguration -ComputerName Target -Path C:\DSCSecure -wait –Verbose -force
Explorer \\target\c$\


