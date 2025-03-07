[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
$KeysPath = Join-Path $Config.MasterPath 'keys'
"Install keys into $KeysPath" | Write-Verbose

$WorkshopArguments = @{
  WorkshopPath    = $Config.WorkshopPath
  WorkshopPattern = '^[0-9]+$'
  AppId           = 107410
}

$Config.Mods + $Config.ServerMods + $Config.ClientMods |
  & $PSScriptRoot/Get-AddonPath.ps1 @WorkshopArguments |
  ForEach-Object {
    Write-Verbose "Copy addon keys from $_"
    Get-ChildItem $_ -Recurse -Filter '*.bikey' | Copy-Item -Destination $KeysPath
  }
