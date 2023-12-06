[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
Stop-ArmaServer -ConfigFilename $ConfigFilename
ArmaServer-InvokeServerProcess -ConfigFilename $ConfigFilename
if ($Config.Headless) {
  ArmaServer-InvokeHeadlessProcess -ConfigFilename $ConfigFilename
}
