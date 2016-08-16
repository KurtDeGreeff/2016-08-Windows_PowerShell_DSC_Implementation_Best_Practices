[DSCLocalConfigurationManager()]
Configuration LCM_Push 
{
	Node Target
	{
		Settings
		{
			AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndAutoCorrect'
			RefreshMode = 'Push'
            
                        	
		}
	}
}

LCM_Push -OutputPath C:\DSCSecureLCM

Set-DSCLocalConfigurationManager -ComputerName Target -Path c:\DSCsecureLCM –Verbose




