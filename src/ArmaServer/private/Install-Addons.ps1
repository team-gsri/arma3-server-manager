[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

# Remarks: we need to download client mods for the bikeys

$AppId = 107410
$Pattern = '^[0-9]+$'
$Config = Import-PowerShellDataFile $ConfigFilename
"Install addons into $($Config.WorkshopPath)" | Write-Verbose

$Arguments = @{
  Path     = $Config.WorkshopPath
  Username = $env:STEAM_USERNAME
  Commands = $Config.Mods + $Config.ServerMods + $Config.ClientMods |
    Where-Object { $_ -match $Pattern } |
    Select-Object -Unique |
    ForEach-Object { "workshop_download_item $AppId $_ validate" }
}

if ($Arguments.Commands.Length -eq 0) { return }
& $PSScriptRoot/Invoke-SteamCmd.ps1 @Arguments
