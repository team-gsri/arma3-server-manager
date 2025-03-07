[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$AppId = 233780
$Config = Import-PowerShellDataFile $ConfigFilename
New-Item $Config.MasterPath -ItemType Directory -Force | Out-Null
"Install server master into $($Config.MasterPath)" | Write-Verbose

$Arguments = @{
  Path     = $Config.MasterPath
  Username = $env:STEAM_USERNAME
  Commands = @("app_update $AppId -beta ""$($Config.Beta)"" validate")
}

& $PSScriptRoot/Invoke-SteamCmd.ps1 @Arguments
