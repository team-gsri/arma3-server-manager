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
$Addons = ($config.Mods + $config.ClientMods + $config.ServerMods) -Match '[0-9]+' | Select-Object -Unique
Write-Debug "Following addons will be downloaded : $Addons"


@( "app_update 233780 validate" ) |`
& $PSScriptRoot/.functions/Start-ArmaCmdCommands.ps1 -Path $Config.MasterPath -Quit

$Addons |`
    ForEach-Object { "workshop_download_item 107410 $_" } |`
    & $PSScriptRoot/.functions/Start-ArmaCmdCommands.ps1 -Path $Config.WorkshopPath -Quit:$Quit