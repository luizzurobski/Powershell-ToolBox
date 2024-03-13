function Get-LZUserLogon {

<#
.SYNOPSIS
    Shows successful logon events for the specified user.
 
.DESCRIPTION
	The Get-LZUserLogon function returns event logs with ID 4624 (successful logons) for a specified user. 
	It requires the AD module.
	The 'StartDate' parameter defines the day from which the logs will be displayed.
	If no value is provided, events will be displayed from 00:00:00 on the current day..
	 
.PARAMETER StartDate
    Sets how many days back will be displayed

.EXAMPLE
     Get-LZUserLogon -Username steve.rogers -ComputerName FileServer02 -StartDate 05/17/2023

.EXAMPLE
     Get-LZUserLogon -Username steve.rogers -ComputerName FileServer02

.NOTES
    Author:  Luiz Zurobski
#>
    
    [CmdletBinding()]
    param (
       [Parameter(Mandatory)]
       [string]$Username,
       [Parameter(Mandatory)]
       [string]$ComputerName,
       [Parameter()]
       [datetime]$StartDate
    )
    if ($PSBoundParameters.ContainsKey("StartDate")) { 
        $Date = $StartDate
    }
    else {
        $Date = Get-Date -Hour 0 -Minute 0 -Second 0
    }
    $UserId = Get-ADUser $Username | Select-Object -ExpandProperty sid  
    Get-WinEvent  -ComputerName $ComputerName -FilterHashtable @{
        Logname="security"
        ID="4624"
        StartTime=$Date
        Data=($UserId).Value
    }
}
