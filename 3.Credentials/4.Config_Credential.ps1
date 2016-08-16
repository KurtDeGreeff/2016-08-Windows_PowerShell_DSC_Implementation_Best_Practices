$ConfigData = @{
    AllNodes = @(
       @{
            NodeName='target'
            CertificateFile = 'c:\cert\ClientAuth.cer'
            #ThumbPrint = ''

        }
    )
}

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
Dirtest -Credential (Get-Credential) -ConfigurationData $ConfigData -OutputPath C:\DSCSecure


