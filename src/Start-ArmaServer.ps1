[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

$TaskInfo = @{
    TaskName = (Get-Item $ConfigFilename).BaseName
    TaskPath = '\Arma3\'
}

& "$PSScriptRoot/Enable-ArmaServer.ps1" -ConfigFilename $ConfigFilename
Start-ScheduledTask @TaskInfo
