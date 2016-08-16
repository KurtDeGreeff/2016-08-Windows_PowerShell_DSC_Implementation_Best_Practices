Configuration DirTest {
    param (
        [pscredential]$credential
    )
    Node Target {
        
        File DirTest1 {
            DestinationPath = 'c:\DirTest'
            Type = 'Directory'
            Ensure = 'Present'
            Credential = $Credential
        }
    }
}
Dirtest -Credential (Get-Credential) -OutputPath c:\DSCSecure

# Send to computers LCM
# Start-DscConfiguration -ComputerName Target -Path C:\DSCSecure –Verbose
