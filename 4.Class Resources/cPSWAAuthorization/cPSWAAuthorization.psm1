enum Ensure {

    Absent
    Present
}

[DscResource()]
class cPSWAAuthorization {
    
    [DscProperty(Key)]
    [string]$RuleName

    [DscProperty(Mandatory)]
    [Ensure] $Ensure

    [DscProperty(Mandatory)]
    [string] $Domain

    [DscProperty(Mandatory)]
    [string] $ComputerName

    [DscProperty(Mandatory)]
    [string] $Group

    [DscProperty(Mandatory)]
    [string] $Configuration

    [cPSWAAuthorization] Get() {
    
    $result=Get-PswaAuthorizationRule -RuleName $this.RuleName -ErrorAction silentlycontinue

	return $this

    }

    [void] Set() {
        
        Write-verbose "Adding new rule"

        Add-PswaAuthorizationRule -UserGroupName $this.Group -ComputerName $this.ComputerName -ConfigurationName $this.Configuration -RuleName $this.RuleName -Force

    }

    [bool] Test() {

        if ($this.Ensure -eq 'Present') {
            $result=Get-PswaAuthorizationRule -RuleName $this.RuleName -ErrorAction silentlycontinue
            $computer = "$($this.Domain)\$($this.ComputerName)" -replace '.company.pri',''
          
    
            If ($result.user -eq $this.Group -and $result.Destination -eq $Computer) {
                Write-verbose "Test for rule passed - nothing to configure"
                Return $true
            }Else {
                Write-Verbose "Test for Rule failed - need to Set"
                Return $False
            }
        }
        
    }
        
}
   
            
     