[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
  [string]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
$Mods = ($config.Mods | & $PSScriptRoot/Get-AddonPath.ps1 -WorkshopPath $Config.WorkshopPath) -Join ';'
$ServerMods = ($config.ServerMods | & $PSScriptRoot/Get-AddonPath.ps1 -WorkshopPath $Config.WorkshopPath) -Join ';'
$ArmaExe = Join-Path $Config.MasterPath 'arma3server_x64.exe'

$Arguments = @(
  "-port=$($Config.Port)"
  '-cpuCount=2'
  '-exThreads=7'
  '-maxMem=8192'
  '-autoInit'
  "-pid=$($Config.ConfigPath)\server.pid"
  '-name=server'
  "-profiles=$($Config.ProfilePath)"
  "-config=$($Config.ConfigPath)\server.cfg"
  "-cfg=$($Config.ConfigPath)\basic.cfg"
  "-mod=${Mods}"
  "-serverMod=${ServerMods}"
)

Write-Verbose 'Start server process'
$Arguments | ConvertTo-Json | Write-Debug
$Process = Start-Process "${ArmaExe}" -ArgumentList ${Arguments} -PassThru
if ($null -ne $Process) {
  $Process.PriorityClass = 'High'
  $Process.ProcessorAffinity = $config.ServerAffinity
}
