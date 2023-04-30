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
    '-client'
    '-connect=localhost'
    "-port=$($Config.Port)"
    """-password=$($Config.Password)"""
    "-pid=$($Config.ConfigPath)\headless.pid"
    '-name=HC'
    "-profiles=$($Config.ProfilePath)"
    "-mod=${Mods};${ServerMods}"
)

# Starting server
Write-Verbose 'Starting headless client'
$Arguments | ConvertTo-Json | Write-Verbose
$Process = Start-Process "${ArmaExe}" -ArgumentList ${Arguments} -PassThru
if ($null -ne $Process) {
  $Process.PriorityClass = 'High'
  $Process.ProcessorAffinity = $config.HeadlessAffinity
}