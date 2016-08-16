Configuration JoinDomain
{ 
    param 
    ( 
        [string[]]$NodeName='localhost', 
 
        [Parameter(Mandatory)] 
        [string]$MachineName, 
 
        [Parameter(Mandatory)] 
        [string]$Domain, 
 
        [Parameter(Mandatory)] 
        [PSCredential]$Credential 
    ) 
 
    #Import the required DSC Resources 
    Import-DscResource -Module xComputerManagement 
 
    Node $NodeName 
    { 
        LocalConfigurationManager
        {
            RefreshMode = 'Push'
            ConfigurationMode = 'ApplyAndAutoCorrect'
            ConfigurationModeFrequencyMins = 15         
        }
        
        xComputer JoinDomain 
        { 
            Name          = $MachineName  
            DomainName    = $Domain 
            Credential    = $Credential 
        } 
    } 
} 
 
$ConfigData = @{   
                 AllNodes = @(        
                              @{     
                                 NodeName = 'localhost'
                                 PSDscAllowPlainTextPassword = $true 
                              } 
                            )  
              } 
 
JoinDomain -ConfigurationData $ConfigData -MachineName 'mem1' -Credential (Get-Credential) -Domain toms.local






