[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
  [string]
  $ConfigFilename
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$Mods = ($config.Mods | ArmaServer-ConvertWorkshopPath -WorkshopPath $Config.WorkshopPath) -Join ';'
$ServerMods = ($config.ServerMods | ArmaServer-ConvertWorkshopPath -WorkshopPath $Config.WorkshopPath) -Join ';'
$ArmaExe = Join-Path $Config.MasterPath arma3server_x64.exe

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

# Starting server
Write-Verbose 'Starting server'
$Arguments | ConvertTo-Json | Write-Verbose
$Process = Start-Process "${ArmaExe}" -ArgumentList ${Arguments} -PassThru
if ($null -ne $Process) {
  $Process.PriorityClass = 'High'
  $Process.ProcessorAffinity = $config.ServerAffinity
}