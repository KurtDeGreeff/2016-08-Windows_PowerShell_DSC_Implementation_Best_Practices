configuration Auth
{
    param
    (
        # Target nodes to apply the configuration
        [Parameter(Mandatory = $true)]
        [string[]]$NodeName    
        
    )

    # Import the module that defines custom resources
    Import-DscResource -Module cPSWAAuthorization
   


    Node $NodeName
    {
        cPSWAAuthorization Rule1 {

            Ensure = 'Present'
            RuleName = 'Rule1'
            Domain = 'Company'
            Group =  'Company\Domain Admins'
            ComputerName = 's1.company.pri'
            Configuration = '*'
            
             

        }
    }
}

Auth -NodeName s1 -OutputPath c:\PWAConfig
# Push the config
Start-DscConfiguration -ComputerName s1 -Path C:\PWAConfig -Wait -Verbose -force