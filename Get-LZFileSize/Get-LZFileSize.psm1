function Get-LZFileSize {
	
<#
.SYNOPSIS
    Get-LZFileSize is a function that calculates the file sizes of a specific folder or subfolders.
 
.DESCRIPTION
    Get-LZFileSize is a function that calculates the file sizes of a specific folder or subfolders.
    
.PARAMETER Path
    Folder path where the file sizes will be calculated.

.PARAMETER UnitMeasure
    Unit of measure for the file size. The default is gigabyte.
    Gigabyte = GB
    Megabyte = MB
    Kilobyte = KB

.PARAMETER DecimalPlaces
    Number of decimal places. The default value is 3.

.LINK
    https://github.com/luizzurobski/Powershell-ToolBox

.EXAMPLE
    Get-LZFileSize -path 'C:\Images'

.EXAMPLE
    Get-LZFileSize -path 'C:\Images' -LengthFormat mb -DecimalPlaces 5

.NOTES
    Author:  Luiz Zurobski
#>

	[CmdletBinding()]
	param (
		[Parameter()]
		[string[]]$path,
        [Parameter()]
        [string]$UnitMeasure = "1GB",
        [Parameter()]
        [string]$DecimalPlaces = "N3"
    )

    #Converting the values inputted by the user to the pattern accepted by the cmdlet.
    $UnitMeasure = "1" + $UnitMeasure
    $DecimalPlaces = "N" + $DecimalPlaces

	$Filesizelist = Get-ChildItem -path $path -ErrorAction silentlycontinue -Recurse | ForEach-Object {
		[PSCustomObject]@{
            Name = $_.Name
            Size_GB = ($_.Length / $UnitMeasure).ToString($DecimalPlaces)
			LastWriteTime = $_.LastWriteTime
            Path = $_.FullName            
		}
	}

	$Filesizelist | Sort-Object -Property Size_GB -Descending | Format-Table -Wrap | more
	
}
