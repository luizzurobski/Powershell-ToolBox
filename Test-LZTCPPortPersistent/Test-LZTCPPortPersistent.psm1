function Test-LZTCPPortPersistent {

<#
.SYNOPSIS
    Persistent tcp port test.
 
.DESCRIPTION
    This function performs a 'ping-like' TCP port test. Type Ctrl + C to exit the loop.  

.EXAMPLE
    Test-LZTCPPortPersistent -DestinationAddress mssqlserver.mycompany.com -PortNumber 1433

.NOTES
    Author:  Luiz Zurobski
#>
    
    [CmdletBinding()]
    param (
        # Name or IP of destination address
        [Parameter()]
        [string]
        $DestinationAddress,
        # TCP port number
        [Parameter()]
        [int]
        $PortNumber       
    )
    while ($true) {
        $result = Test-NetConnection -ComputerName $DestinationAddress -Port $PortNumber -WarningAction SilentlyContinue
        $status = if ($result.TcpTestSucceeded) { "Success" } else { "Failed" }
        $status
        Start-Sleep -Seconds 1
    }
}
