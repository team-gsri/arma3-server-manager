[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename

Write-Debug 'Attempting to stop server if running'
& "$PSScriptRoot/../Stop-ArmaServer.ps1" -ConfigFilename $ConfigFilename

If ($Config.Update) {
    Write-Debug 'Updating server before start'
    & "$PSScriptRoot/../Update-ArmaServer.ps1" -ConfigFilename $ConfigFilename
}

Write-Debug 'Starting server process'
& "$PSScriptRoot/New-ArmaServerProcess.ps1" -ConfigFilename $ConfigFilename

if ($Config.Headless) {
    Write-Debug 'Starting headless process'
    & "$PSScriptRoot/New-ArmaServerHeadless.ps1" -ConfigFilename $ConfigFilename
}