[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [switch]
    $Faster,

    [Parameter()]
    [string]
    $Username = $env:STEAM_USERNAME
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$FunctionsPath = Join-Path $PSScriptRoot .functions
$MissionPath = Join-Path $Config.MasterPath mpmissions
$KeyPath = Join-Path $Config.MasterPath keys
$Addons = $config.Mods + $config.ClientMods + $config.ServerMods | Select-Object -Unique

& "$PSScriptRoot/Stop-ArmaServer.ps1" -ConfigFilename $ConfigFilename

# Download game and workshop contents
if (-Not $Faster) {
    & "$PSScriptRoot/Start-Download.ps1" -ConfigFilename $ConfigFilename -Username $Username -Quit
}

#  Update content
$Addons | & "$FunctionsPath/Copy-BohemiaKeys.ps1" -WorkshopPath $Config.WorkshopPath -DestinationPath $KeyPath
& "$FunctionsPath/Copy-Mission.ps1" -Target $MissionPath -SourceType $config.Mission.Type -Source $config.Mission.Path
& "$FunctionsPath/Set-ArmaServerConfig.ps1" -ConfigFilename $ConfigFilename