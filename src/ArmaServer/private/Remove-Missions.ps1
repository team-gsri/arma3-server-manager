[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
$MissionsPath = Join-Path $Config.MasterPath 'mpmissions'
"Remove missions from $MissionsPath" | Write-Verbose

if (Test-Path $MissionsPath) {
  Remove-Item $MissionsPath/* -Recurse -Filter '*.pbo'
}
