[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
  [string]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
if (-not $Config.Headless) { return }

$Mods = ($config.Mods | & $PSScriptRoot/Get-AddonPath.ps1 -WorkshopPath $Config.WorkshopPath) -Join ';'
$ServerMods = ($config.ServerMods | & $PSScriptRoot/Get-AddonPath.ps1 -WorkshopPath $Config.WorkshopPath) -Join ';'
$ArmaExe = Join-Path $Config.MasterPath 'arma3server_x64.exe'

$Arguments = @(
  '-client'
  '-connect=localhost'
  "-port=$($Config.Port)"
  """-password=$($Config.Password)"""
  "-pid=$($Config.ConfigPath)\headless.pid"
  '-name=HC'
  "-profiles=$($Config.ProfilePath)"
  "-mod=${Mods};${ServerMods}"
)

Write-Verbose 'Start headless client process'
$Arguments | ConvertTo-Json | Write-Debug
$Process = Start-Process "${ArmaExe}" -ArgumentList ${Arguments} -PassThru
if ($null -ne $Process) {
  $Process.PriorityClass = 'High'
  $Process.ProcessorAffinity = $config.HeadlessAffinity
}
