[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [switch]
    $Quit
)

$Config = Import-PowerShellDataFile $ConfigFilename
$Addons = ($config.Mods + $config.ClientMods + $config.ServerMods) -Match '^[0-9]+$' | Select-Object -Unique
Write-Debug "Following addons will be downloaded : $Addons"

@( 233780 ) | ForEach-Object {
    "app_update $_ validate"
} | & "$PSScriptRoot/.functions/Start-SteamcmdCommands.ps1" -Path $Config.MasterPath -Quit

if ($null -ne $Addons) {
    $Addons | ForEach-Object {
        "workshop_download_item 107410 $_"
    } | & "$PSScriptRoot/.functions/Start-SteamcmdCommands.ps1" -Path $Config.WorkshopPath -Quit:$Quit
}