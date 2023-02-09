[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$TemplatePath = Join-Path $PSScriptRoot ../.templates
$MissionPath = Join-Path $Config.MasterPath mpmissions

# Initiliaze configuration
If (-Not(Test-Path $Config.ConfigPath)) { New-Item $Config.ConfigPath -ItemType Directory | Out-Null }
If (Test-Path $Config.ConfigPath) { Get-ChildItem $Config.ConfigPath -Filter *.cfg | Remove-Item -Force }
Copy-Item $TemplatePath/basic.cfg $(Join-Path $Config.ConfigPath basic.cfg)

# Map values
$Mission = Get-ChildItem $MissionPath -Filter *.pbo | Select-Object -First 1
$ServerConfig = @{
    Hostname         = $Config.Hostname
    Password         = $Config.Password
    Players          = $Config.Players
    Admins           = $Config.Admins
    Mission          = $Mission.BaseName
    VerifySignatures = $Config.VerifySignatures
    DisableChannels  = $Config.DisableChannels
    File             = Join-Path $Config.ConfigPath server.cfg
}

# Write configuration file
Write-Debug 'Updating server configuration with these parameters:'
$ServerConfig | ConvertTo-Json -Compress -AsArray | Write-Debug
& "$PSScriptRoot/New-ArmaServerConfig.ps1" @ServerConfig