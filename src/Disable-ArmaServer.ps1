[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [switch]
    $Stop
)

$TaskInfo = @{
    TaskName = (Get-Item $ConfigFilename).BaseName
    TaskPath = '\Arma3\'
}

if ($Stop) {
    & "$PSScriptRoot/Stop-ArmaServer.ps1" -ConfigFilename $ConfigFilename
}

$TaskInfo | ConvertTo-Json -Compress | Write-Debug
Disable-ScheduledTask @TaskInfo