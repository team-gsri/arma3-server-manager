[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
$KeysPath = Join-Path $Config.MasterPath 'keys'
"Remove keys from $KeysPath" | Write-Verbose

if (Test-Path $KeysPath) {
  Remove-Item $KeysPath/* -Recurse -Filter '*.bikey'
}
