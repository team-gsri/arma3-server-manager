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
$HeadlessPidFile = Join-Path $ConfigPath headless.pid

$Port = $Config.Port
$Password = $Config.Password
$Mods = ($config.Mods | ForEach-Object { ($_ -Match '^[0-9]+$') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ServerMods = ($config.ServerMods | ForEach-Object { ($_ -Match '^[0-9]+$') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ArmaExe = Join-Path $MasterPath arma3server_x64.exe

$HeadlessArguments = @(
    '-client'
    '-connect=localhost'
    "-port=${Port}"
    """-password=${Password}"""
    "-pid=${HeadlessPidFile}"
    '-name=HC'
    "-profiles=${ProfilePath}"
    "-mod=${Mods};${ServerMods}"
)

# Starting headless
Write-Debug 'Starting headless client process with parameters:'
$HeadlessArguments | ForEach-Object { Write-Debug $_ }
$HeadlessProcess = Start-Process "${ArmaExe}" -ArgumentList $HeadlessArguments -PassThru
if ($null -ne $HeadlessProcess) {
    $HeadlessProcess.PriorityClass = 'High'
    $HeadlessProcess.ProcessorAffinity = $config.HeadlessAffinity
}