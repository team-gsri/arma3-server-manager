[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$WorkshopPath = $Config.WorkshopPath
$MasterPath = $Config.MasterPath
$ConfigPath = $Config.ConfigPath
$ProfilePath = $Config.ProfilePath
$ServerPidFile = Join-Path $ConfigPath server.pid

$Port = $Config.Port
$Mods = ($config.Mods | ForEach-Object { ($_ -Match '^[0-9]+$') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ServerMods = ($config.ServerMods | ForEach-Object { ($_ -Match '^[0-9]+$') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ArmaExe = Join-Path $MasterPath arma3server_x64.exe

$ServerArguments = @(
    "-port=${Port}"
    '-cpuCount=2'
    '-exThreads=7'
    '-maxMem=8192'
    '-autoInit'
    "-pid=${ServerPidFile}"
    '-name=server'
    "-profiles=${ProfilePath}"
    "-config=${ConfigPath}\server.cfg"
    "-cfg=${ConfigPath}\basic.cfg"
    "-mod=${Mods}"
    "-serverMod=${ServerMods}"
)

# Starting server
Write-Debug 'Starting game server process with parameters:'
$ServerArguments | ForEach-Object { Write-Debug $_ }
$ServerProcess = Start-Process "${ArmaExe}" -ArgumentList ${ServerArguments} -PassThru
if ($null -ne $ServerProcess) {
    $ServerProcess.PriorityClass = 'High'
    $ServerProcess.ProcessorAffinity = $config.ServerAffinity
}