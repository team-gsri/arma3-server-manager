[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-GithubSecretFile not found' } })]
    [string]
    $GithubSecretFile = $(Join-Path $env:USERPROFILE .secrets/github.txt),

    [Parameter()]
    [switch]
    $Update,

    [Parameter()]
    [switch]
    $Headless
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$WorkshopPath = $Config.WorkshopPath
$MasterPath = $Config.MasterPath
$ConfigPath = $Config.ConfigPath
$ProfilePath = $Config.ProfilePath
$ServerPidFile = Join-Path $ConfigPath server.pid
$HeadlessPidFile = Join-Path $ConfigPath headless.pid

# Stop server if running
& "$PSScriptRoot/../Stop-ServerInstance.ps1" -ConfigFilename $ConfigFilename

# Update server if requested
If ($Update) {
    & "$PSScriptRoot/../Update-ServerInstance.ps1" -ConfigFilename $ConfigFilename
}

# Server command line config
$Port = $Config.Port
$Password = $Config.Password
$Mods = ($config.Mods | ForEach-Object { ($_ -Match '[0-9]+') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ServerMods = ($config.ServerMods | ForEach-Object { ($_ -Match '[0-9]+') ? "$WorkshopPath\steamapps\workshop\content\107410\$_" : $_ }) -Join ';'
$ArmaExe = Join-Path $MasterPath arma3server_x64.exe

# Start server
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
$ServerArguments | ForEach-Object { Write-Debug $_ }
$ServerProcess = Start-Process "${ArmaExe}" -ArgumentList ${ServerArguments} -PassThru
if ($null -ne $ServerProcess) {
    $ServerProcess.PriorityClass = 'High'
    $ServerProcess.ProcessorAffinity = $config.ServerAffinity
}

if ($Headless) {
    # Start headless
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
    $HeadlessArguments | ForEach-Object { Write-Debug $_ }
    $HeadlessProcess = Start-Process "$armaExe" -ArgumentList $HeadlessArguments -PassThru
    if ($null -ne $HeadlessProcess) {
        $HeadlessProcess.PriorityClass = 'High'
        $HeadlessProcess.ProcessorAffinity = $config.HeadlessAffinity
    }
}